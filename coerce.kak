declare-user-mode coerce

map global coerce -docstring "snake case" 's' "<esc> | sed -E 's/[ -]/_/g;s/([^_])([A-Z])/\1_\l\2/g;s/([A-Z])/\l\1/g' <ret>"
map global coerce -docstring "camel case" 'c' "<esc> | sed -E 's/[ _-]([a-z])/\U\1/g;s/^([A-Z])/\l\1/g' <ret>"
