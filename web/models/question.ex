defmodule PerceiveMe.Question do
  use PerceiveMe.Web, :model

  schema "questions" do
    field :language, :string
    field :question_1, :string
    field :question_2, :string
    field :question_3, :string
    field :question_4, :string
    field :question_5, :string
    timestamps
  end

  @required_fields ~w(language
    question_1 question_2 question_3 question_4 question_5)
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


  def questions_for_lang(lang) do
    query = from question in PerceiveMe.Question,
            where: question.language == ^lang
    PerceiveMe.Repo.one! query
  end
end
