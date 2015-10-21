defmodule CardTokeniser.Token do
  use CardTokeniser.Web, :model

  schema "token" do
    field :token, :string
    field :initiator_id, :string
    field :card_no, :string
    field :card_valid_from, :string
    field :card_valid_thru, :string
    field :amount, :float
    field :currency, :string

    timestamps
  end

  @required_fields ~w(token initiator_id card_no card_valid_from card_valid_thru amount currency)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
