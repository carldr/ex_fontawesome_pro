if Code.ensure_loaded?(Phoenix.LiveView) do
  defmodule FontAwesomePro.LiveView do
    @moduledoc """
    A LiveView component for rendering Font Awesome icons.

    ## Examples

        <FontAwesomePro.LiveView.Icon name="rocket-launch" type="regular" class="h-4 w-4" />
    """

    use Phoenix.Component

    def icon(assigns) do
      opts = assigns[:opts] || []
      type_opts = type_to_opts(assigns)
      class_opts = class_to_opts(assigns)

      opts =
        opts
        |> Keyword.merge(type_opts)
        |> Keyword.merge(class_opts)

      assigns = assign(assigns, opts: opts)

      ~H"""
      <%= FontAwesomePro.icon(@name, @opts) %>
      """
    end

    defp type_to_opts(assigns) do
      type = assigns[:type] || FontAwesomePro.default_type()

      unless type do
        raise ArgumentError,
              "type prop is required if default type is not configured."
      end

      [type: type]
    end

    defp class_to_opts(assigns) do
      if assigns[:class] do
        [class: assigns.class]
      else
        []
      end
    end
  end
end
