#!/usr/bin/env bash
# Generate N Kotlin source files to trigger ARG_MAX on Linux linker.
# Usage: ./generate-sources.sh [count]
# Default: 15000 files (generates ~25000 cache archives with incremental compilation)

set -euo pipefail

COUNT="${1:-15000}"
SRC_DIR="src/linuxX64Main/kotlin/generated"

echo "Generating $COUNT Kotlin source files in $SRC_DIR ..."

mkdir -p "$SRC_DIR"

for i in $(seq 0 $((COUNT - 1))); do
    FILE_ID=$(printf "%05d" "$i")
    cat > "$SRC_DIR/generated_file_${FILE_ID}.kt" <<EOF
// Auto-generated source file $i
// Each file produces one cache archive (.a) during incremental compilation.
fun generated_file_${FILE_ID}(): Long = ${i}L
EOF
done

echo "Generated $COUNT files in $SRC_DIR"
echo "Total size: $(du -sh "$SRC_DIR" | cut -f1)"
