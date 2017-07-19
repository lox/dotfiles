
if command -v yarn &> /dev/null ; then
  export PATH="$PATH:$HOME/.yarn/bin"
fi

if command -v npm &> /dev/null ; then
  export PATH="$PATH:$HOME/.npm/bin"
fi

export PATH="$PATH:node_modules/.bin"
