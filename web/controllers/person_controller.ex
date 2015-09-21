defmodule PerceiveMe.PersonController do
  use PerceiveMe.Web, :controller

  alias PerceiveMe.Person
  alias PerceiveMe.Question
  alias PerceiveMe.Answer
  alias PerceiveMe.Repo

  def me(conn, _params) do
    language = "es"
    questions = Question.questions_for_lang(language)
    render conn, "me.html", questions: questions, language: language
  end

  def answer(conn, params) do
    uuid = Ecto.UUID.generate
    photo_path = save_photo(uuid, params["person"])
    create_user(uuid, photo_path, params["answers"])
    text conn, inspect(params)
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
