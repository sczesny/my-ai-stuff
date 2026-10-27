# Source me: helpers for gen.sh. Paths are relative to the current directory.

# Log of fetched files and used sections, read by check. A file, because copy often runs in a pipe subshell.
seen=$(mktemp)
trap 'rm -f "$seen"' EXIT

# fetch <owner/repo> <branch> <path> <output>
fetch() {
  curl -fsSL "https://raw.githubusercontent.com/$1/$2/$3" -o "$4"
  printf 'file\t%s\t\n' "$4" >> "$seen"
}

# from <file without .md>: source file for the following copy/intro/ignore calls
from() {
  src=$1
}

# copy <heading>
# Prints the section from <heading> up to the next heading of the same or higher level, plus a blank line.
copy() {
  awk -v h="$1" -v intro="${intro:-0}" '
    /^```/ { fence = !fence }
    !fence && /^#+ / { lvl = index($0, " ") - 1; if (on && (intro || lvl <= depth)) exit; if ($0 == h) { on = 1; depth = lvl } }
    on { if ($0 == "") { blanks++; next } for (; blanks; blanks--) print ""; print }
    END { if (on) print ""; exit !on }
  ' "$src.md" || { echo "not found: '$1' in $src.md" >&2; return 1; }
  printf '%s\t%s\t%s\n' "$([[ ${intro:-0} == 1 ]] && echo self || echo tree)" "$src.md" "$1" >> "$seen"
}

# intro <heading>: like copy, but stops at the first subheading
intro() {
  intro=1 copy "$1"
}

# ignore <heading>: marks the section and its subsections as handled without printing them
ignore() {
  copy "$1" > /dev/null
}

# check: warns about every heading in a fetched file that was not copied, introduced or ignored
check() {
  local f
  for f in $(awk -F'\t' '$1 == "file" { print $2 }' "$seen" | sort -u); do
    awk -F'\t' -v f="$f" '
      NR == FNR { if ($2 == f) done[$1, $3] = 1; next }
      /^```/ { fence = !fence }
      fence || !/^#+ / { next }
      {
        lvl = index($0, " ") - 1
        while (n && lv[n] >= lvl) n--
        covered = done["self", $0] || done["tree", $0]
        for (i = 1; i <= n; i++) if (tree[i]) covered = 1
        lv[++n] = lvl; tree[n] = done["tree", $0]
        if (!covered) print "warning: " f ": not copied or ignored: " $0 > "/dev/stderr"
      }
    ' "$seen" "$f"
  done
}
