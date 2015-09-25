# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PerceiveMe.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

PerceiveMe.Repo.insert!(%PerceiveMe.Question{
  language: "es",
  question_1: "uno",
  question_2: "dos",
  question_3: "tres",
  question_4: "cuatro",
  question_5: "cinco"
})