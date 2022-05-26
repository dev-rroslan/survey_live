defmodule SurveyLive.Accounts.Member do
  @moduledoc """
  The Member schema is basically 1 to 1 with a User and uses the same table.
  """
  use SurveyLive.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string

    has_many :memberships, SurveyLive.Accounts.Membership, foreign_key: :user_id
    has_many :accounts, through: [:memberships, :account]

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [])
    |> validate_required([])
  end
end
