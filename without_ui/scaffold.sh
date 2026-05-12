#!/usr/bin/env bash
# scaffold.sh — create an agentic repo structure from a situation*.md file
#
# Usage:
#   ./scaffold.sh situation01.md [target_dir]
#   ./scaffold.sh situation02.md my_project
#
# Arguments:
#   $1  Path to a situation*.md file (required)
#   $2  Target directory name (optional, defaults to repo name derived from md file)

set -euo pipefail

# ── helpers ──────────────────────────────────────────────────────────────────

red()    { echo -e "\033[0;31m$*\033[0m"; }
green()  { echo -e "\033[0;32m$*\033[0m"; }
yellow() { echo -e "\033[0;33m$*\033[0m"; }
bold()   { echo -e "\033[1m$*\033[0m"; }

usage() {
  echo "Usage: $0 <situation_file.md> [target_directory]"
  echo ""
  echo "  situation_file.md   one of: situation01.md  situation02.md  situation03.md"
  echo "  target_directory    optional — defaults to the filename stem (e.g. situation01)"
  echo ""
  echo "Examples:"
  echo "  $0 situation01.md"
  echo "  $0 situation02.md my_multiagent_project"
  exit 1
}

# ── args ─────────────────────────────────────────────────────────────────────

[[ $# -lt 1 ]] && usage

MD_FILE="$1"
[[ ! -f "$MD_FILE" ]] && { red "Error: file not found — $MD_FILE"; exit 1; }

# default target dir = stem of md file (situation01, situation02, …)
STEM="$(basename "$MD_FILE" .md)"
TARGET="${2:-$STEM}"

# ── confirm overwrite ─────────────────────────────────────────────────────────

if [[ -d "$TARGET" ]]; then
  yellow "Warning: directory '$TARGET' already exists."
  read -rp "Continue and merge into it? [y/N] " yn
  [[ "$yn" =~ ^[Yy]$ ]] || { echo "Aborted."; exit 0; }
fi

mkdir -p "$TARGET"
bold "Scaffolding into: $(realpath "$TARGET")"

# ── parse ## Paths block ──────────────────────────────────────────────────────
# Reads lines between ```paths and ``` markers

parse_block() {
  local file="$1"
  local tag="$2"
  awk "
    /^\`\`\`${tag}/{found=1; next}
    found && /^\`\`\`/{found=0; next}
    found && /^[^[:space:]]/{print}
    found && /^[[:space:]]+/{print}
  " "$file" | sed '/^[[:space:]]*$/d'
}

DIRS=$(parse_block "$MD_FILE" "paths")
STUBS=$(parse_block "$MD_FILE" "stubs")

# ── create directories ────────────────────────────────────────────────────────

DIR_COUNT=0
while IFS= read -r dir; do
  [[ -z "$dir" ]] && continue
  mkdir -p "$TARGET/$dir"
  echo "  📁  $dir"
  (( DIR_COUNT++ ))
done <<< "$DIRS"

# ── create stub files ─────────────────────────────────────────────────────────

STUB_COUNT=0
while IFS= read -r stub; do
  [[ -z "$stub" ]] && continue
  full_path="$TARGET/$stub"
  # ensure parent dir exists (handles files in subdirs not listed under paths)
  mkdir -p "$(dirname "$full_path")"
  if [[ ! -f "$full_path" ]]; then
    touch "$full_path"
    echo "  📄  $stub"
    (( STUB_COUNT++ ))
  else
    echo "  ⏭   $stub (exists, skipped)"
  fi
done <<< "$STUBS"

# ── add .gitkeep to empty dirs ────────────────────────────────────────────────

KEEP_COUNT=0
while IFS= read -r dir; do
  [[ -z "$dir" ]] && continue
  full_dir="$TARGET/$dir"
  if [[ -d "$full_dir" && -z "$(ls -A "$full_dir")" ]]; then
    touch "$full_dir/.gitkeep"
    (( KEEP_COUNT++ ))
  fi
done <<< "$DIRS"

# ── summary ───────────────────────────────────────────────────────────────────

echo ""
green "✓ Done"
echo "  Directories  : $DIR_COUNT"
echo "  Stub files   : $STUB_COUNT"
echo "  .gitkeep     : $KEEP_COUNT (empty dirs)"
echo ""
bold "  cd $TARGET"
echo ""
