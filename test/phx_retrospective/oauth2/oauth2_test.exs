defmodule PhxRetrospective.Oauth2Test do
  use PhxRetrospective.DataCase

  alias PhxRetrospective.Oauth2

  describe "users" do
    alias PhxRetrospective.Oauth2.User

    @valid_attrs %{email: "some email", screen_name: "some screen_name"}
    @update_attrs %{email: "some updated email", screen_name: "some updated screen_name"}
    @invalid_attrs %{email: nil, screen_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Oauth2.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Oauth2.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Oauth2.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Oauth2.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.screen_name == "some screen_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Oauth2.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Oauth2.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.screen_name == "some updated screen_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Oauth2.update_user(user, @invalid_attrs)
      assert user == Oauth2.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Oauth2.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Oauth2.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Oauth2.change_user(user)
    end
  end
end
