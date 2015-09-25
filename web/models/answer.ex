defmodule PerceiveMe.Answer do
  use PerceiveMe.Web, :model

  schema "answers" do
    belongs_to :person, PerceiveMe.Person

    field :language, :string
    field :answer_1, :string
    field :answer_2, :string
    field :answer_3, :string
    field :answer_4, :string
    field :answer_5, :string
    timestamps
  end

  @required_fields ~w(language
    answer_1 answer_2 answer_3 answer_4 answer_5)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:language, max: 2, min: 2)
  end

  def from_url_with_lang(person_url, lang) do
    query = from answer in PerceiveMe.Answer,
      join: person in PerceiveMe.Person, on: answer.person_id == person.id,
      where: answer.language == ^lang,
      where: person.url == ^person_url,
      limit: 1,
      preload: [:person]
    PerceiveMe.Repo.one! query
  end

  def answers_for_lang(lang) do
    query = from answer in PerceiveMe.Answer,
      where: answer.language == ^lang,
      limit: 1,
      preload: [:person]
    PerceiveMe.Repo.one! query
  end
  
end
