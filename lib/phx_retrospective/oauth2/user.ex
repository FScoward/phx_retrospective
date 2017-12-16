defmodule PhxRetrospective.Oauth2.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhxRetrospective.Oauth2.User


  schema "users" do
    field :email, :string
    field :screen_name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :screen_name])
    |> validate_required([:email, :screen_name])
  end
end
