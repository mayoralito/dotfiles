#!/bin/sh
#
# Homebrew
#
# Installs Homebrew if not present.

if ! command -v brew >/dev/null 2>&1; then
  echo "  Installing Homebrew for you."

  if [ "$(uname)" = "Darwin" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  elif [ "$(uname -s)" = "Linux" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
fi

exit 0