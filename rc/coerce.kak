define-command -docstring "Enter coerce mode.
coerce-mode contains functions for coercing selections to various
cases

Bind coerce-mode with a mapping:
    map global normal '<key' ': coerce-mode<ret>'
" \
coerce-mode %{ require-module coerce; evaluate-commands 'enter-user-mode coerce' }

provide-module coerce %§

try %{ declare-user-mode coerce }

define-command -docstring "coerce selection to snake_case" coerce-snakecase %{
  execute-keys '<a-:><a-;>s |-|[a-z][A-Z]<ret>;a<space><esc>s[-\s]+<ret>c_<esc><a-i>w`'
}

§

hook global ModuleLoaded coerce %{
  map global coerce -docstring "snake_case" 's' "<esc>: require-module coerce; coerce-snakecase<ret>"
}
