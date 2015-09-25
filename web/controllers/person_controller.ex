defmodule PerceiveMe.PersonController do
  use PerceiveMe.Web, :controller

  alias PerceiveMe.Person
  alias PerceiveMe.Question
  alias PerceiveMe.Answer
  alias PerceiveMe.Perception
  alias PerceiveMe.Repo

  def show_form(conn, _params) do
    language = "es"
    questions = Question.questions_for_lang(language)
    render conn, "me.html", questions: questions, language: language
  end

  def create(conn, params) do
    uuid = Ecto.UUID.generate
    photo_path = save_photo(uuid, params["person"])
    create_user(uuid, photo_path, params["answers"])
    text conn, inspect(params)
  end

  def show_random(conn, params) do
    answers = Answer.answers_for_lang("es")
    redirect conn, to: "/they/#{answers.person.url}"
  end

  def show_them(conn, %{"person_url" => url} = params) do
    person = Person.find_by_url(url)
    render conn, "they.html", person: person
  end

  def perceive(conn, params) do
    %{"perception" => perception} = params
    person = Person.find_by_id(person_id)
    answers = Answer.from_url_with_lang(person.url, "es")

    tags = String.split(tags, ",", trim: true)
    Enum.each(tags, fn(tag) -> 
      perception = Perception.changeset(%Perception{}, %{perception | tag: tag})
      Repo.insert! perception
    end)

    render conn, "they.html", person: person, answers: answers
  end
  

  defp save_photo(uuid, %{"file" => upload}) do
    ext = Path.extname(upload.filename)
    photo_path = "/people_photos/#{uuid}#{ext}"
    full_path = "#{Mix.Project.app_path}/priv/static/images/#{photo_path}" 
    File.cp!(upload.path, full_path)
    photo_path
  end

  defp save_photo(uuid, %{"snap" => snap}) do
    "data:image/jpeg;base64," <> encoded_data = snap
    image_content = Base.decode64!(encoded_data)
    photo_path = "/people_photos/#{uuid}.jpeg"
    full_path = "#{Mix.Project.app_path}/priv/static/images/#{photo_path}" 
    File.write!(full_path, image_content)
    photo_path
  end

  defp create_user(uuid, photo_path, answers) do
    person = %Person{country: "MX", photo: photo_path, url: uuid}
    person = Repo.insert!(person)

    answer = %Answer{person_id: person.id}
    change = Answer.changeset(answer, answers)
    Repo.insert!(change)
  end
  
end
