defmodule FontAwesomeProTest do
  use ExUnit.Case, async: true
  doctest FontAwesomePro

  test "renders icon" do
    assert FontAwesomePro.icon("rocket-launch", type: "regular")
           |> Phoenix.HTML.safe_to_string() =~ "<svg"
  end

  test "renders icon with attribute" do
    assert FontAwesomePro.icon("rocket-launch", type: "regular", class: "h-4 w-4")
           |> Phoenix.HTML.safe_to_string() =~ ~s(<svg class="h-4 w-4")
  end

  test "converts opts to attributes" do
    assert FontAwesomePro.icon("rocket-launch", type: "regular", aria_hidden: true)
           |> Phoenix.HTML.safe_to_string() =~ ~s(<svg aria-hidden="true")
  end

  test "raises if icon name does not exist" do
    msg = ~s(icon "hello" with type "regular" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      FontAwesomePro.icon("hello", type: "regular")
    end
  end

  test "raises if type is missing" do
    msg = ~s(expected type in options, got: [])

    assert_raise ArgumentError, msg, fn ->
      FontAwesomePro.icon("rocket-launch")
    end
  end

  test "raises if icon type does not exist" do
    msg = ~s(expected type to be one of #{inspect(FontAwesomePro.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      FontAwesomePro.icon("rocket-launch", type: "world")
    end
  end
end

defmodule FontAwesomeProConfigTest do
  use ExUnit.Case

  test "renders icon with default type" do
    Application.put_env(:ex_fontawesome_pro, :type, "regular")

    assert FontAwesomePro.icon("rocket-launch")
           |> Phoenix.HTML.safe_to_string() =~ "<svg"
  end

  test "raises if default icon type does not exist" do
    Application.put_env(:ex_fontawesome_pro, :type, "world")

    msg = ~s(expected default type to be one of #{inspect(FontAwesomePro.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      FontAwesomePro.icon("rocket-launch")
    end
  end
end
