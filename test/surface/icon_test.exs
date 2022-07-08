defmodule FontAwesomePro.Surface.IconTest do
  use FontAwesomePro.ConnCase, async: true

  alias FontAwesomePro.Surface.Icon

  defmodule ViewWithIcon do
    use Surface.LiveView

    data aria_hidden, :boolean, default: false

    def handle_event("toggle_aria_hidden", _, socket) do
      {:noreply, assign(socket, :aria_hidden, !socket.assigns.aria_hidden)}
    end

    def render(assigns) do
      ~F"""
      <Icon name="rocket-launch" type="regular" opts={aria_hidden: @aria_hidden} />
      """
    end
  end

  test "renders icon" do
    html =
      render_surface do
        ~F"""
        <Icon name="rocket-launch" type="regular" />
        """
      end

    assert html =~ "<svg"
  end

  test "renders icon with class" do
    html =
      render_surface do
        ~F"""
        <Icon name="rocket-launch" type="regular" class="h-4 w-4" />
        """
      end

    assert html =~ ~s(<svg class="h-4 w-4")
  end

  test "renders icon with opts" do
    html =
      render_surface do
        ~F"""
        <Icon name="rocket-launch" type="regular" opts={aria_hidden: true} />
        """
      end

    assert html =~ ~s(<svg aria-hidden="true")
  end

  test "class prop overrides opts prop" do
    html =
      render_surface do
        ~F"""
        <Icon name="rocket-launch" type="regular" class="hello" opts={class: "world"} />
        """
      end

    assert html =~ ~s(<svg class="hello")
  end

  test "raises if icon name does not exist" do
    msg = ~s(icon "hello" with type "regular" does not exist.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="hello" type="regular" />
        """
      end
    end
  end

  test "raises if type is missing" do
    msg = ~s(type prop is required if default type is not configured.)

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="hello" />
        """
      end
    end
  end

  test "raises if icon type does not exist" do
    msg = ~s(expected type to be one of #{inspect(FontAwesomePro.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="rocket-launch" type="world" />
        """
      end
    end
  end

  test "updates when opts change", %{conn: conn} do
    {:ok, view, html} = live_isolated(conn, ViewWithIcon)

    assert html =~ ~s(<svg aria-hidden="false")

    assert render_click(view, :toggle_aria_hidden) =~
             ~s(<svg aria-hidden="true")

    assert render_click(view, :toggle_aria_hidden) =~
             ~s(<svg aria-hidden="false")
  end
end

defmodule FontAwesomePro.Surface.IconConfigTest do
  use FontAwesomePro.ConnCase

  alias FontAwesomePro.Surface.Icon

  test "renders icon with default type" do
    Application.put_env(:ex_fontawesome_pro, :type, "regular")

    html =
      render_surface do
        ~F"""
        <Icon name="rocket-launch" />
        """
      end

    assert html =~ "<svg"
  end

  test "raises if default icon type does not exist" do
    Application.put_env(:ex_fontawesome_pro, :type, "world")

    msg = ~s(expected default type to be one of #{inspect(FontAwesomePro.types())}, got: "world")

    assert_raise ArgumentError, msg, fn ->
      render_surface do
        ~F"""
        <Icon name="rocket-launch" />
        """
      end
    end
  end
end
