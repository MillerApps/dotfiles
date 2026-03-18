{pkgs}:
pkgs.writeShellApplication {
  name = "install-homebrew";
  runtimeInputs = [pkgs.curl];
  text = ''
    set -euo pipefail

    case "$(/usr/bin/uname -m)" in
      arm64)
        prefix="/opt/homebrew"
        ;;
      x86_64)
        prefix="/usr/local"
        ;;
      *)
        printf 'Unsupported macOS architecture for Homebrew: %s\n' "$(/usr/bin/uname -m)" >&2
        exit 1
        ;;
    esac

    brew_bin="$prefix/bin/brew"

    if [ -x "$brew_bin" ]; then
      printf 'Homebrew already installed at %s.\n' "$brew_bin"
      exit 0
    fi

    if ! /usr/bin/xcode-select -p >/dev/null 2>&1; then
      printf 'Xcode Command Line Tools are required before Homebrew can be installed.\n' >&2
      exit 1
    fi

    printf 'Homebrew not found at %s; running the official installer.\n' "$brew_bin"
    /bin/bash -c "$(${pkgs.curl}/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    if [ ! -x "$brew_bin" ]; then
      printf 'Homebrew installation finished but %s was not created.\n' "$brew_bin" >&2
      exit 1
    fi

    printf 'Homebrew ready at %s.\n' "$brew_bin"
  '';
}
