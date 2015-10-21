defmodule CardTokeniser.TokenView do
  use CardTokeniser.Web, :view

  def render("index.json", %{token: token}) do
    %{data: render_many(token, CardTokeniser.TokenView, "token.json")}
  end

  def render("show.json", %{token: token}) do
    %{data: render_one(token, CardTokeniser.TokenView, "token.json")}
  end

  def render("token.json", %{token: token}) do
    %{id: token.id,
      token: token.token,
      initiator_id: token.initiator_id,
      card_no: token.card_no,
      card_valid_from: token.card_valid_from,
      card_valid_thru: token.card_valid_thru,
      amount: token.amount,
      currency: token.currency}
  end
end
