
if command -v yarn &> /dev/null ; then
  path+=("$HOME/.yarn/bin")
fi

path+=("node_modules/.bin")