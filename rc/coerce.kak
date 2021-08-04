define-command -docstring "Enter coerce mode.
coerce-mode contains functions for coercing selections to various
cases

Bind coerce-mode with a mapping:
    map global normal '<key' ': coerce-mode<ret>'
" \
coerce-mode %{ require-module coerce; evaluate-commands 'enter-user-mode coerce' }

provide-module coerce %§

try %{ declare-user-mode coerce }

# coerce to snake_case
define-command -hidden \
coerce-snakecase %{
  # the try prevents an error when the selection is already snake_case
  try %{
    execute-keys -itersel '<a-:><a-;>s |-|[a-z][A-Z]<ret>;a<space><esc>s[-\s]+<ret>c_<esc><a-i>w`'
  }
}

§

hook global ModuleLoaded coerce %{
  map global coerce -docstring "snake_case" 's' "<esc>: require-module coerce; coerce-snakecase<ret>"
  map global coerce -docstring "SHOUT_CASE" 'S' "<esc>: require-module coerce; coerce-snakecase; execute-keys '~'<ret>"
}

# manual testing corpus:
#   some_string
#   Some string
#   SomeString
#   some-string
#   someString
#   SOME_STRING
