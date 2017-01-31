#!/usr/bin/env bash

# This script will generate common icons using ImageMagick's 'convert'.
# Assumptions:
# - ImageMagick is installed.
# - The image is on the first page.

# Paths
INPUT_FILE=$1
OUTPUT_DIR=$2

# Sizes to export
SIZES=( 36 48 57 60 70 72 76 96 114 120 128 144 150 152 167 180 192 256 310 400 )

echo "Converting $INPUT_FILE and exporting to $OUTPUT_DIR..."

# Create directories
mkdir -p "$OUTPUT_DIR/"

# Export SVSG
convert "$INPUT_FILE[0]" "$OUTPUT_DIR/icon.svg"

# Export favicons
convert -resize x16 -gravity center -crop 16x16+0+0 "$INPUT_FILE[0]" "$OUTPUT_DIR/favicon-16x16.ico"
convert -resize x32 -gravity center -crop 32x32+0+0 "$INPUT_FILE[0]" "$OUTPUT_DIR/favicon-32x32.ico"
convert -resize x48 -gravity center -crop 48x48+0+0 "$INPUT_FILE[0]" "$OUTPUT_DIR/favicon-48x48.ico"
convert "$OUTPUT_DIR/favicon-16x16.ico" "$OUTPUT_DIR/favicon-32x32.ico" "$OUTPUT_DIR/favicon-48x48.ico" "$OUTPUT_DIR/favicon.ico"

# Export icons that will be used for Apple, Android and Microsoft
for size in "${SIZES[@]}"
do
    convert -resize x${size} -gravity center -crop ${size}x${size}+0+0 "$INPUT_FILE[0]" "$OUTPUT_DIR/${size}x${size}.png"
done
