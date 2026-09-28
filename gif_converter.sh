#!/usr/bin/env bash
#
# Video to GIF Converter (Bash & FFmpeg)
# Bash port of gif_converter.ps1
#

# Get the directory where the script is located, and switch to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR" || exit 1

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "=== Video to GIF Converter (FFmpeg) ==="

# Ask for input file
read -rp "Enter input video filename (leave blank to use first .mkv file): " inputFile

# If empty, auto-select first MKV
if [[ -z "$inputFile" ]]; then
    mkvFile=$(find "$SCRIPT_DIR" -maxdepth 1 -iname "*.mkv" | sort | head -n 1)

    if [[ -z "$mkvFile" ]]; then
        echo -e "${RED}No .mkv file found in this directory.${NC}"
        exit 1
    fi

    inputFile="$(basename "$mkvFile")"
    echo -e "${YELLOW}Using first MKV file found: $inputFile${NC}"
fi

# Validate file exists
if [[ ! -f "$inputFile" ]]; then
    echo -e "${RED}File not found: $inputFile${NC}"
    exit 1
fi

# Ask for output filename
read -rp "Enter output GIF filename (leave blank for auto name): " outputFile

# Default output name if blank
if [[ -z "$outputFile" ]]; then
    outputFile="${inputFile%.*}.gif"
    echo -e "${YELLOW}Using default output: $outputFile${NC}"
fi

# FPS
read -rp "Enter FPS (default 10 | 10-15 recommended, lower = smaller file): " fps
if [[ -z "$fps" ]]; then fps=10; fi

# Width (optional)
read -rp "Enter width (leave blank to keep original size | 480-800 recommended for smaller GIFs): " width

# Build scale filter
if [[ -z "$width" ]]; then
    scaleFilter="fps=$fps"
    echo -e "${YELLOW}Keeping original resolution${NC}"
else
    scaleFilter="fps=$fps,scale=${width}:-1:flags=lanczos"
    echo -e "${YELLOW}Resizing to width $width (aspect ratio preserved)${NC}"
fi

palette="palette.png"

echo -e "\nGenerating palette..."
ffmpeg -i "$inputFile" -vf "$scaleFilter,palettegen" "$palette"

echo "Creating GIF..."
ffmpeg -i "$inputFile" -i "$palette" -filter_complex "$scaleFilter[x];[x][1:v]paletteuse" "$outputFile"

# Cleanup palette
if [[ -f "$palette" ]]; then
    rm -f "$palette"
fi

echo -e "\n${GREEN}Done! Output saved as $outputFile${NC}"
