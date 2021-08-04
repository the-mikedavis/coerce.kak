# coerce.kak

a [vim-abolish](https://github.com/tpope/vim-abolish#coercion)-style casing
coercion plugin for the [kakoune](https://kakoune.org) editor

### Installation

You can use the built-in plugin insfrastructure in kakoune by adding
`rc/coerce.kak` to the autoload directory: `~/.config/kak/autoload`.

Or use the wonderful [`plug.kak`](https://github.com/andreyorst/plug.kak)

```kak
plug 'the-mikedavis/coerce.kak' %{
  map global normal + ': coerce-mode'
}
```

### Usage

`coerce.kak` defines a user-mode called `coerce` with bindings for different
casings. You must bind the `coerce` user-mode to a mode key:
the [kakoune Wiki](https://github.com/mawww/kakoune/wiki/Normal-mode-commands)
documents some unbound keys you may use. For example, this will bind the
`coerce` user-mode to `+` in normal mode.

`coerce.kak` also provides a `coerce-mode` command that lazily requires
the `coerce` module. This can improve start-up time.

```kak
map global normal + ': coerce-mode'
```

If you use the user-mode/leader-key feature, you can bind a key to get to
the `coerce` mode from the user mode:

```kak
map global user c ': coerce-mode' -docstring "coercion mode"
```

Now you can coerce the casing of any selection by entering that mode and
pressing

- `c` for camelCase
- `p` for PascalCase
- `s` for snake_case
- `k` for kebab-case

Want to use these bindings without the `coerce` user-mode? Feel free to
copy/paste the ones you want out to a custom configuration (the Unlicense
has you covered :).

### Other casings

I have only implemented the casings I find useful. PRs are welcome for
more casings, but be mindful that many casings can be created with
the existing implemented casings plus default kakoune bindings like
`~` (uppercase the selection).

For example, to implement SHOUT_CASE, one may simply run the snake_case
coersion on a selection and then type `~`.

These can be added à la carte to your own configuration by adding a hook
to the `ModuleLoaded` like so:

```kak
hook global ModuleLoaded coerce %{
  map global coerce -docstring "SHOUT_CASE" 'S' "<esc>: require-module coerce; coerce-snake; execute-keys '~'<ret>"
}
```

Or with `plug.kak`:

```kak
plug 'the-mikedavis/coerce.kak' config %{
  # set up the binding for coerce-mode here
} defer %{
  map global coerce -docstring "SHOUT_CASE" 'S' "<esc>: require-module coerce; coerce-snake; execute-keys '~'<ret>"
}
```

### How it works

`coerce.kak` defines a module called `coerce` and a user-mode (also called
`coerce`. The module defines some functions that use kakoune's
`execute-keys` feature to operate on selections. `execute-keys` allows
one to work across multiple selections and does not have any external
dependencies. In contrast, the first version of this plugin piped out
to `sed` which does not work across multiple selections and can be brittle
depending on the distribution of `sed` installed on any given machine.

Generally the coercions start by coercing to either snake or camel case
and then modifying those resulting selections into kebab or pascal case.

If you're interested in what those big `execute-keys` strings do,
try pasting them into [`@Delapouite`](https://github.com/Delapouite)'s
awesome [Kakoune Explain](https://delapouite.github.io/kakoune-explain/) tool.

### See also

What about
[`dmerejkowsky/kak-subvert`](https://github.com/dmerejkowsky/kak-subvert)?
That looks good and might even provide better replacement results but I
don't wanna have to install the rust toolchain :P

Admittedly I did not see
[`case.kak`](https://gitlab.com/FlyingWombat/case.kak/-/tree/master) before
writing this plugin. `case.kak` has more casings and helper functions, but
it can error out on edge cases such as trying to convert something in
snake_case to snake_case. This plugin tries to be as forgiving of input as
possible.
