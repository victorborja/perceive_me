defmodule PerceiveMe.QuestionTest do
  use PerceiveMe.ModelCase

  alias PerceiveMe.Question

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Question.changeset(%Question{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Question.changeset(%Question{}, @invalid_attrs)
    refute changeset.valid?
  end
end
