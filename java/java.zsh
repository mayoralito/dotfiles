# Java configuration
if [ -x /usr/libexec/java_home ]; then
  # Prefer OpenJDK 17, fall back to any available Java
  if /usr/libexec/java_home -v 17 &>/dev/null; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 17)
  else
    export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null || echo "")
  fi
fi

# Android SDK configuration
# Prefer user's home directory location, then common locations
if [ -d "$HOME/Library/Android/sdk" ]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
elif [ -d "/usr/local/share/android-sdk" ]; then
  export ANDROID_HOME="/usr/local/share/android-sdk"
elif [ -d "/usr/local/lib/android/sdk" ]; then
  export ANDROID_HOME="/usr/local/lib/android/sdk"
elif [ -d "/opt/android/sdk" ]; then
  export ANDROID_HOME="/opt/android/sdk"
fi

# Add Android SDK tools to PATH if ANDROID_HOME is set
if [ -n "$ANDROID_HOME" ]; then
  export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"
  
  # Add cmdline-tools if available (newer SDK structure)
  if [ -d "$ANDROID_HOME/cmdline-tools/latest/bin" ]; then
    export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
  elif [ -d "$ANDROID_HOME/cmdline-tools/tools/bin" ]; then
    export PATH="$ANDROID_HOME/cmdline-tools/tools/bin:$PATH"
  fi
fi