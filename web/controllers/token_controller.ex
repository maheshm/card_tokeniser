defmodule CardTokeniser.TokenController do
  use CardTokeniser.Web, :controller

  alias CardTokeniser.Token

  plug :scrub_params, "token" when action in [:create, :update]

  def index(conn, _params) do
    token = Repo.all(Token)
    render(conn, "index.json", token: token)
  end

  def create(conn, %{"token" => token_params}) do
    changeset = Token.changeset(%Token{}, token_params)

    case Repo.insert(changeset) do
      {:ok, token} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", token_path(conn, :show, token))
        |> render("show.json", token: token)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CardTokeniser.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    token = Repo.get!(Token, id)
    render(conn, "show.json", token: token)
  end

  def update(conn, %{"id" => id, "token" => token_params}) do
    token = Repo.get!(Token, id)
    changeset = Token.changeset(token, token_params)

    case Repo.update(changeset) do
      {:ok, token} ->
        render(conn, "show.json", token: token)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(CardTokeniser.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    token = Repo.get!(Token, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(token)

    send_resp(conn, :no_content, "")
  end
end
