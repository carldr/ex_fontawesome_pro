defmodule FontAwesomePro do
  @moduledoc """
  This package adds a convenient way of using [Font Awesome](https://fontawesome.com) SVGs with your Phoenix, Phoenix LiveView and Surface applications.

  You can find the original docs [here](https://fontawesome.com) and repo [here](https://github.com/FortAwesome/Font-Awesome).

  Current FontAwesome version: 6.2.1

  ## Installation

  Add `ex_fontawesome` to the list of dependencies in `mix.exs`:

      def deps do
        [
          {:ex_fontawesome_pro, git: "https://github.com/carldr/ex_fontawesome_pro"}
        ]
      end

  Then run `mix deps.get`.

  You then need to get the icons from Font Awesome, so we can build ex_fontawesome_pro :

  ```
  FONTAWESOME_NPM_AUTH_TOKEN=...token... \
  EX_FONTAWESOME_PRO=deps/ex_fontawesome_pro \
  mix ex_fontawesome_pro
  ```

  Replacing `...token...` with your token.  See https://fontawesome.com/docs/web/setup/packages
  for details.

  Then this is a bit of a hack - you need to remove your `_build` directory so ex_fontawesome_pro
  is rebuilt with the icons you've just downloaded.

  But once you have, you can compile your app and enjoy pro icons!

  ## Usage

  #### With Eex or Leex

      <%= FontAwesomePro.icon("rocket-launch", type: "regular", class: "h-4 w-4") %>

  #### With Heex

      <FontAwesomePro.LiveView.icon name="rocket-launch" type="regular" class="h-4 w-4" />

  #### With Surface

      <FontAwesomePro.Surface.Icon name="rocket-launch" type="regular" class="h-4 w-4" />

  ## Config

  Defaults can be set in the `FontAwesomePro` application configuration.

      config :ex_fontawesome_pro, type: "regular"

  """

  alias __MODULE__.Icon

  icon_paths = "node_modules/@fortawesome/fontawesome-pro/svgs/**/*.svg" |> Path.wildcard()

  icons =
    for icon_path <- icon_paths do
      @external_resource Path.relative_to_cwd(icon_path)
      Icon.parse!(icon_path)
    end

  types = icons |> Enum.map(& &1.type) |> Enum.uniq()
  names = icons |> Enum.map(& &1.name) |> Enum.uniq()

  @types types
  @names names

  @doc "Returns a list of available icon types"
  @spec types() :: [String.t()]
  def types(), do: @types

  @doc "Returns a list of available icon names"
  @spec names() :: [String.t()]
  def names(), do: @names

  @doc false
  def default_type() do
    case Application.get_env(:ex_fontawesome_pro, :type) do
      nil ->
        nil

      type when is_binary(type) ->
        if type in types() do
          type
        else
          raise ArgumentError,
                "expected default type to be one of #{inspect(types())}, got: #{inspect(type)}"
        end

      type ->
        raise ArgumentError,
              "expected default type to be one of #{inspect(types())}, got: #{inspect(type)}"
    end
  end

  @doc """
  Generates an icon.

  Options may be passed through to the SVG tag for custom attributes.

  ## Options

    * `:type` - the icon type. Accepted values are #{inspect(types)}. Required if default type is not configured.
    * `:class` - the css class added to the SVG tag

  ## Examples

      icon("rocket-launch", type: "regular", class: "h-4 w-4")
      #=> <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">
            ...
          </svg>
  """
  @spec icon(String.t(), keyword) :: Phoenix.HTML.safe()
  def icon(name, opts \\ []) when is_binary(name) and is_list(opts) do
    {type, opts} = Keyword.pop(opts, :type, default_type())

    unless type do
      raise ArgumentError,
            "expected type in options, got: #{inspect(opts)}"
    end

    unless type in types() do
      raise ArgumentError,
            "expected type to be one of #{inspect(types())}, got: #{inspect(type)}"
    end

    icon(type, name, opts)
  end

  for %Icon{type: type, name: name, file: file} <- icons do
    defp icon(unquote(type), unquote(name), opts) do
      attrs = Icon.opts_to_attrs(opts)
      Icon.insert_attrs(unquote(file), attrs)
    end
  end

  defp icon(type, name, _opts) do
    raise ArgumentError,
          "icon #{inspect(name)} with type #{inspect(type)} does not exist."
  end
end
