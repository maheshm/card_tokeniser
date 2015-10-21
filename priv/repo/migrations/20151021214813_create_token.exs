defmodule CardTokeniser.Repo.Migrations.CreateToken do
  use Ecto.Migration

  def change do
    create table(:token) do
      add :token, :string
      add :initiator_id, :string
      add :card_no, :string
      add :card_valid_from, :string
      add :card_valid_thru, :string
      add :amount, :float
      add :currency, :string

      timestamps
    end

  end
end
