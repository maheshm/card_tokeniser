defmodule CardTokeniser.TokenControllerTest do
  use CardTokeniser.ConnCase

  alias CardTokeniser.Token
  @valid_attrs %{amount: "120.5", card_no: "some content", card_valid_from: "some content", card_valid_thru: "some content", currency: "some content", initiator_id: "some content", token: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, token_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    token = Repo.insert! %Token{}
    conn = get conn, token_path(conn, :show, token)
    assert json_response(conn, 200)["data"] == %{"id" => token.id,
      "token" => token.token,
      "initiator_id" => token.initiator_id,
      "card_no" => token.card_no,
      "card_valid_from" => token.card_valid_from,
      "card_valid_thru" => token.card_valid_thru,
      "amount" => token.amount,
      "currency" => token.currency}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, token_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, token_path(conn, :create), token: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Token, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, token_path(conn, :create), token: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    token = Repo.insert! %Token{}
    conn = put conn, token_path(conn, :update, token), token: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Token, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    token = Repo.insert! %Token{}
    conn = put conn, token_path(conn, :update, token), token: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    token = Repo.insert! %Token{}
    conn = delete conn, token_path(conn, :delete, token)
    assert response(conn, 204)
    refute Repo.get(Token, token.id)
  end
end
