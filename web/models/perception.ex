defmodule PerceiveMe.Perception do
  use PerceiveMe.Web, :model

  schema "perceptions" do
    belongs_to :person, PerceiveMe.Person

    field :tag, :string
    field :after_answers, :boolean, default: false
    timestamps
  end

  @required_fields ~w(person_id tag after_answers)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:tag, min: 3)
  end
  
end
