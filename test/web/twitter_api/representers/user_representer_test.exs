defmodule Pleroma.Web.TwitterAPI.Representers.UserRepresenterTest do
  use Pleroma.DataCase

  alias Pleroma.User
  alias Pleroma.Web.TwitterAPI.Representers.UserRepresenter

  setup do
    user = %User{
      email: "test@example.org",
      name: "Test Name",
      nickname: "testname",
      password_hash: Comeonin.Pbkdf2.hashpwsalt("test"),
      bio: "A tester."
    }
    user = Repo.insert!(user)
    [user: user]
  end

  test "A user", %{user: user} do
    image = "https://placehold.it/48x48"
    represented = %{
      "id" => user.id,
      "name" => user.name,
      "screen_name" => user.nickname,
      "description" => user.bio,
      # Fake fields
      "favourites_count" => 0,
      "statuses_count" => 0,
      "friends_count" => 0,
      "followers_count" => 0,
      "profile_image_url" => image,
      "profile_image_url_https" => image,
      "profile_image_url_profile_size" => image,
      "profile_image_url_original" => image,
      "following" => false,
      "rights" => %{}
    }

    assert represented == UserRepresenter.to_map(user)
  end
end
