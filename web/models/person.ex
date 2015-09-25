defmodule PerceiveMe.Person do
  use PerceiveMe.Web, :model

  schema "people" do
    field :country, :string
    field :photo, :string
    field :url, :string
    timestamps
  end

  @required_fields ~w(country url photo)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:country, max: 3, min: 3)
  end

  def find_by_id(id) do
    PerceiveMe.Repo.one!(from p in PerceiveMe.Person, where: p.id == ^id)
  end

  def find_by_url(url) do
    PerceiveMe.Repo.one!(from p in PerceiveMe.Person, where: p.url == ^url)
  end
  
end
