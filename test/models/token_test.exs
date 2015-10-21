defmodule CardTokeniser.TokenTest do
  use CardTokeniser.ModelCase

  alias CardTokeniser.Token

  @valid_attrs %{amount: "120.5", card_no: "some content", card_valid_from: "some content", card_valid_thru: "some content", currency: "some content", initiator_id: "some content", token: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Token.changeset(%Token{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Token.changeset(%Token{}, @invalid_attrs)
    refute changeset.valid?
  end
end
