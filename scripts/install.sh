#!/bin/sh
# Copies the two reviewed 1.1.0 files. No downloads, runtime or settings changes.
set -eu

usage() {
    cat <<'USAGE'
Usage: sh scripts/install.sh [--source-dir DIRECTORY] [--codex-home DIRECTORY]

Source defaults to ../output/evil-neuro relative to this script.
Destination defaults to CODEX_HOME/pets/evil-neuro, or
$HOME/.codex/pets/evil-neuro when CODEX_HOME is unset or empty.
The destination must not already exist. Only pet.json and spritesheet.webp
are installed. --codex-home supports an explicitly chosen test destination.
USAGE
}

fail() {
    printf '%s\n' "Error: $*" >&2
    exit 1
}

script_dir=$(CDPATH= cd -P -- "$(dirname -- "$0")" && pwd)
source_dir=$script_dir/../output/evil-neuro
task_codex_home=${CODEX_HOME:-}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --source-dir)
            [ "$#" -ge 2 ] && [ -n "$2" ] || fail '--source-dir needs a directory.'
            source_dir=$2
            shift 2
            ;;
        --codex-home)
            [ "$#" -ge 2 ] && [ -n "$2" ] || fail '--codex-home needs a directory.'
            task_codex_home=$2
            shift 2
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *) fail "Unknown argument: $1" ;;
    esac
done

if [ -z "$task_codex_home" ]; then
    [ -n "${HOME:-}" ] || fail 'HOME is not set; pass --codex-home explicitly.'
    task_codex_home=$HOME/.codex
fi

[ -d "$source_dir" ] || fail "Source directory does not exist: $source_dir"
source_dir=$(CDPATH= cd -P -- "$source_dir" && pwd)
case "$task_codex_home" in
    /*) ;;
    *) task_codex_home=$(pwd)/$task_codex_home ;;
esac
destination_dir=$task_codex_home/pets/evil-neuro

if command -v sha256sum >/dev/null 2>&1; then
    checksum_tool=sha256sum
elif command -v shasum >/dev/null 2>&1; then
    checksum_tool=shasum
elif command -v openssl >/dev/null 2>&1; then
    checksum_tool=openssl
else
    fail 'A SHA-256 tool is required: sha256sum, shasum or openssl.'
fi

file_sha256() {
    case "$checksum_tool" in
        sha256sum) sha256sum -- "$1" | awk '{print $1}' ;;
        shasum) shasum -a 256 -- "$1" | awk '{print $1}' ;;
        openssl) openssl dgst -sha256 "$1" | sed 's/^.*= //' ;;
    esac
}

expected_manifest=799d2d35ddc67245de799a498d02bf08e06c8c4919f50fdf6c82dc9929d366e4
expected_spritesheet=b2dc8c336c500c843a708e52fc0c0e523724fcd1b2707578ca314597188830a1

# Complete all source validation before writing to the installation target.
[ -f "$source_dir/pet.json" ] || fail 'Missing source pet.json.'
[ -f "$source_dir/spritesheet.webp" ] || fail 'Missing source spritesheet.webp.'
[ "$(file_sha256 "$source_dir/pet.json")" = "$expected_manifest" ] ||
    fail 'pet.json checksum differs from reviewed 1.1.0; no pet files were written.'
[ "$(file_sha256 "$source_dir/spritesheet.webp")" = "$expected_spritesheet" ] ||
    fail 'spritesheet.webp checksum differs from reviewed 1.1.0; no pet files were written.'

# The pinned full-file hash proves this is the exact already-reviewed JSON.
# These field checks provide clear errors without requiring Python or jq.
grep -Eq '"id"[[:space:]]*:[[:space:]]*"evil-neuro"[[:space:]]*,' "$source_dir/pet.json" ||
    fail 'Manifest id must be evil-neuro.'
grep -Eq '"spriteVersionNumber"[[:space:]]*:[[:space:]]*2[[:space:]]*,' "$source_dir/pet.json" ||
    fail 'Manifest spriteVersionNumber must be the number 2.'
grep -Eq '"spritesheetPath"[[:space:]]*:[[:space:]]*"spritesheet\.webp"[[:space:]]*$' "$source_dir/pet.json" ||
    fail 'Manifest spritesheetPath must be spritesheet.webp.'

# -L also catches a dangling symlink. Never install into an existing target.
if [ -e "$destination_dir" ] || [ -L "$destination_dir" ]; then
    fail "Target already exists; nothing was overwritten: $destination_dir"
fi
mkdir -p -- "$task_codex_home/pets"
mkdir -- "$destination_dir" || fail "Could not create a new target: $destination_dir"

# POSIX noclobber refuses files created concurrently; no force-copy or deletion.
(set -C; cat "$source_dir/pet.json" > "$destination_dir/pet.json") ||
    fail 'Could not create pet.json; newly created partial directory was retained.'
(set -C; cat "$source_dir/spritesheet.webp" > "$destination_dir/spritesheet.webp") ||
    fail 'Could not create spritesheet.webp; newly created partial directory was retained.'

[ "$(file_sha256 "$destination_dir/pet.json")" = "$expected_manifest" ] &&
[ "$(file_sha256 "$destination_dir/spritesheet.webp")" = "$expected_spritesheet" ] ||
    fail 'Copied file verification failed; newly created directory was retained for inspection.'

printf '%s\n' "Installed the two verified Evil Neuro 1.1.0 files: $destination_dir"
printf '%s\n' 'Open the app pet settings, refresh the list, then select Evil Neuro.'
printf '%s\n' 'No existing pets, app settings or execution backends were changed.'
