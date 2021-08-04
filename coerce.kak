declare-user-mode coerce

map global coerce -docstring "snake_case" 's' "<esc> | sed -E 's/[ -]/_/g;s/([^_])([A-Z])/\1_\l\2/g;s/([A-Z])/\l\1/g' <ret>"
map global coerce -docstring "SHOUT_CASE" 'S' "<esc> | sed -E 's/[ -]/_/g;s/([^_])([A-Z])/\1_\l\2/g;s/([a-z])/\U\1/g' <ret>"
map global coerce -docstring "PascalCase" 'p' "<esc> | sed -E 's/[ _-]([a-z])/\U\1/g;s/^([a-z])/\U\1/g' <ret>"
map global coerce -docstring "camelCase" 'c' "<esc> | sed -E 's/[ _-]([a-z])/\U\1/g;s/^([A-Z])/\l\1/g' <ret>"
map global coerce -docstring "kebab-case" 'k' "<esc> | sed -E 's/[ _]/-/g;s/([^-])([A-Z])/\1-\l\2/g;s/([A-Z])/\l\1/g' <ret>"
