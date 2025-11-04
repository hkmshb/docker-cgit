#!/bin/sh
# Extended cgit syntax highlighting filter with Markdown rendering
# Works in Alpine Linux Docker environments (uses low-footprint tools).
#
# Uses 'lowdown' (preferred) or 'cmark' if available for Markdown → HTML.
# Falls back to plain text if neither tool is installed.

BASENAME="$1"
EXTENSION="${BASENAME##*.}"

[ "${BASENAME}" = "${EXTENSION}" ] && EXTENSION=txt
[ -z "${EXTENSION}" ] && EXTENSION=txt

# map Makefile and Makefile.* to .mk
[ "${BASENAME%%.*}" = "Makefile" ] && EXTENSION=mk

# --- Markdown rendering block ---
case "$EXTENSION" in
  md|markdown|mdown|mkd)
    # Try Markdown renderers in order of preference
    if command -v lowdown >/dev/null 2>&1; then
      # lowdown is small and perfect for Alpine
      # NOTE: source-filter wraps content within <pre><code> markup so added
      # </code></pre> to cancel effect and have markdown render properly
      echo '</code></pre><style>@import url("/gfm.css");</style>'
      echo '<div class="markdown-body">'
      exec lowdown -t html | sed 's/<\/?code>//g'
      echo '</div><pre><code>'
    else
      # fallback: wrap raw text
      echo "<pre><code>"
      cat
      echo "</code></pre>"
      exit 0
    fi
  ;;

  *)
    # --- Syntax highlighting for all other files ---
    if command -v highlight >/dev/null 2>&1; then
      exec highlight --force --inline-css -f -I -O xhtml -S "$EXTENSION" --style github 2>/dev/null
    else
      # fallback to plain text if highlight is missing
      echo "<pre><code>"
      cat
      echo "</code></pre>"
      exit 0
    fi
  ;;
esac
