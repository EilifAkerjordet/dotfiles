#!/bin/bash
# pnpm-bundle: Brewfile-like management for global pnpm packages

PNPMFILE="$HOME/dotfiles/Pnpmfile"

case "$1" in
  install)
    echo "Installing global pnpm packages from Pnpmfile..."
    grep -v '^#' "$PNPMFILE" | grep -v '^$' | xargs -I {} pnpm add -g {}
    ;;
  check)
    echo "Checking global pnpm packages..."
    missing=0
    while IFS= read -r pkg; do
      [[ "$pkg" =~ ^#.*$ ]] && continue
      [[ -z "$pkg" ]] && continue
      if ! pnpm list -g "$pkg" --depth=0 2>/dev/null | grep -q "$pkg"; then
        echo "✗ $pkg (not installed)"
        missing=$((missing + 1))
      else
        echo "✓ $pkg"
      fi
    done < "$PNPMFILE"
    [ $missing -eq 0 ] && echo "\nAll packages installed!" || echo "\n$missing package(s) missing"
    ;;
  dump)
    echo "Creating Pnpmfile from currently installed packages..."
    echo "# Global pnpm packages" > "$PNPMFILE"
    echo "# Install with: ./pnpm-bundle.sh install" >> "$PNPMFILE"
    echo "# Check with: ./pnpm-bundle.sh check" >> "$PNPMFILE"
    echo "" >> "$PNPMFILE"
    pnpm list -g --depth=0 --json | jq -r '.[] | .dependencies | keys[]' >> "$PNPMFILE"
    echo "Pnpmfile updated at $PNPMFILE"
    ;;
  *)
    echo "Usage: $0 {install|check|dump}"
    echo ""
    echo "  install  Install all packages from Pnpmfile"
    echo "  check    Check which packages are installed/missing"
    echo "  dump     Generate Pnpmfile from currently installed packages"
    ;;
esac
