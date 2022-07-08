# FontAwesome Pro

![CI](https://github.com/miguel-s/ex_fontawesome/actions/workflows/ci.yml/badge.svg)

This package adds a convenient way of using [Font Awesome](https://fontawesome.com) Pro SVGs with your Phoenix, Phoenix LiveView and Surface applications.

You can find the original docs [here](https://fontawesome.com) and repo [here](https://github.com/FortAwesome/Font-Awesome).

Current FontAwesome version: 6.1.1

## Installation

Add `ex_fontawesome` to the list of dependencies in `mix.exs`:

    def deps do
      [
        {
          :ex_fontawesome_pro,
          git: "https://github.com/carldr/ex_fontawesome_pro",
        }
      ]
    end

Then run `mix deps.get`.

You then need to get the icons from Font Awesome, so we can build ex_fontawesome_pro :

FONTAWESOME_NPM_AUTH_TOKEN=...token... EX_FONTAWESOME_PRO=deps/ex_fontawesome_pro mix ex_fontawesome_pro

Replacing `...token...` with your token.  See https://fontawesome.com/docs/web/setup/packages
for details.

You can then compile your app and enjoy pro icons!

## Usage

#### With Eex or Leex

```elixir
<%= FontAwesomePro.icon("rocket-launch", type: "regular", class: "h-4 w-4") %>
```

#### With Heex

```elixir
<FontAwesomePro.LiveView.icon name="rocket-launch" type="regular" class="h-4 w-4" />
```

#### With Surface

```elixir
<FontAwesomePro.Surface.Icon name="rocket-launch" type="regular" class="h-4 w-4" />
```

## Config

Defaults can be set in the `FontAwesomePro` application configuration.

```elixir
config :ex_fontawesome_pro, type: "regular"
```

## License

MIT. See [LICENSE](https://github.com/carldr/ex_fontawesome_pro/blob/master/LICENSE) for more details.
