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
    %{"person" => %{"file" => upload}} = params

    ext = Path.extname(upload.filename)

    File.mkdir_p("web/static/assets/people_photos")
    File.cp!(upload.path, "web/static/assets/people_photos/#{uuid}#{ext}")

    photo_path = "people_photos/#{uuid}#{ext}"
    person = %Person{country: "MX", photo: photo_path, url: uuid}
    person = Repo.insert!(person)


    answer = %Answer{person_id: person.id}
    change = Answer.changeset(answer, Map.get(params, "answers")) 
    Repo.insert!(change)

    text conn, inspect(params)
  end
  
end
