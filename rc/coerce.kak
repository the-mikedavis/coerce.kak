define-command -docstring "Enter coerce mode.

`coerce-mode` contains functions for changing the casing used
in a selection.

Bind coerce-mode with a mapping, for example on + in normal mode:

    map global normal '+' ': coerce-mode<ret>'
" \
coerce-mode %{ require-module coerce; evaluate-commands 'enter-user-mode coerce' }

provide-module coerce %§

try %{ declare-user-mode coerce }

define-command -hidden coerce-snake %{
  # the try prevents an error when the selection is already snake_case
  #
  # for example in SHOUT_CASE there is nothing to select here, so we
  # catch the failure and instead attempt to downcase the selection
  evaluate-commands -itersel %{
    try %{
      execute-keys -itersel '<a-:><a-;>s |-|[a-z][A-Z]<ret>;a<space><esc>s[-\s]+<ret>c_<esc><a-i>w`'
    } catch %{
      execute-keys -itersel '`'
    }
  }
}

define-command -hidden coerce-kebab %{
  evaluate-commands -itersel %{
    coerce-snake
    # this try prevents failure when the snake_case has no underscores
    try %{
      execute-keys -itersel 's_<ret>c-<esc><a-i>w'
    }
  }
}

define-command -hidden coerce-camel %{
  evaluate-commands -itersel %{
    coerce-snake
    # this try prevents failure when the snake_case has no underscores
    try %{
      execute-keys -itersel 's_<ret>d~<a-i>w'
    }
  }
}

define-command -hidden coerce-pascal %{
  evaluate-commands -itersel %{
    coerce-camel
    execute-keys -itersel '<a-:><a-;>;~'
  }
}

§

hook global ModuleLoaded coerce %{
  map global coerce -docstring "snake_case" 's' "<esc>: require-module coerce; coerce-snake<ret>"
  map global coerce -docstring "kebab-case" 'k' "<esc>: require-module coerce; coerce-kebab<ret>"
  map global coerce -docstring "camelCase"  'c' "<esc>: require-module coerce; coerce-camel<ret>"
  map global coerce -docstring "PascalCase" 'p' "<esc>: require-module coerce; coerce-pascal<ret>"
}

# manual testing corpus:
#   some_string
#   Some string
#   SomeString
#   some-string
#   someString
#   SOME_STRING
