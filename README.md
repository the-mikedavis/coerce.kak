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
- `S` for SHOUT_CASE

Want to use these bindings without the `coerce` user-mode? Feel free to
copy/paste the ones you want out to a custom configuration (the Unlicense
has you covered :).

### How it works

The `coerce.kak` implementation is quite small: it opens a pipe (`|`) to
`sed` which uses the proper search-and-replace for each casing. The pipe
operation in kakoune passes the current selection to some command line
function and replaces the selection with the output.

Note that some of the features used by these `sed` invocations assume that
you are using GNU `sed`, most notably the `;` for separating multiple
search-and-replace options.

### See also

What about
[`dmerejkowsky/kak-subvert`](https://github.com/dmerejkowsky/kak-subvert)?
That looks good and might even provide better replacement results but I
don't wanna have to install the rust toolchain :P
