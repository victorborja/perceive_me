defmodule PerceiveMe.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :language,    :string # en / es / jp
      add :question_1,  :string
      add :question_2,  :string
      add :question_3,  :string
      add :question_4,  :string
      add :question_5,  :string
      timestamps
    end

    create table(:people) do
      add :country,     :string 
      add :photo,       :string
      add :url,         :string
      timestamps
    end

    create table(:answers) do
      add :person_id, references(:people)
      add :language,  :string # en / es / jp
      add :answer_1,  :string
      add :answer_2,  :string
      add :answer_3,  :string
      add :answer_4,  :string
      add :answer_5,  :string
      timestamps
    end

    create table(:perceptions) do
      add :person_id,     references(:people)
      add :tag,           :string
      add :after_answers, :boolean
      timestamps
    end

  end

end
