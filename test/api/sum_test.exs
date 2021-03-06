defmodule Plasm.Api.SumTest do
  use Plasm.ApiCase

  test ".sum" do
    plasm_query_string =
      Plasm.User
      |> Plasm.sum(:age)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        select: sum(u.age)
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
