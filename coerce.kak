declare-user-mode coerce

map global coerce -docstring "coerce to camel case" 'c' "<esc> | sed -E 's/_([a-z])/\U\1/g' <ret>"
