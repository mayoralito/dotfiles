#!/usr/bin/env bash

#!/usr/bin/env bash 

set -euo pipefail  # Exit on error, unset var, or pipefail

# Find the directory of this script to source ruby-installer.sh reliably
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the Ruby installer script
if [ -f "$SCRIPT_DIR/ruby-installer.sh" ]; then
  source "$SCRIPT_DIR/ruby-installer.sh"
else
  echo "ruby-installer.sh not found in $SCRIPT_DIR" >&2
  exit 1
fi

# Check if gem is available
if ! command -v gem >/dev/null 2>&1; then
  echo "Ruby gem command not found. Ensure Ruby is installed." >&2
  exit 1
fi

gem update --system
gem install cocoapods -v 1.14.3
gem install bundler:2.5.21

