defmodule Plasm.Api.UpdatedAfterTest do
  use Plasm.ApiCase

  test ".updated_after with an Ecto.DateTime" do
    ecto_date_time = Ecto.DateTime.utc

    plasm_query_string =
      Plasm.User
      |> Plasm.updated_after(ecto_date_time)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.updated_at > ^ecto_date_time
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end

  test ".updated_after with a castable Ecto.DateTime" do
    castable_ecto_date_time = "2014-04-17T14:00:00Z"
    {:ok, ecto_date_time} = Ecto.DateTime.cast(castable_ecto_date_time)

    plasm_query_string =
      Plasm.User
      |> Plasm.updated_after(castable_ecto_date_time)
      |> query_to_string

    ecto_query_string =
      Ecto.Query.from(
        u in Plasm.User,
        where: u.updated_at > ^ecto_date_time
      )
      |> query_to_string

    assert plasm_query_string == ecto_query_string
  end
end
