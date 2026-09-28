# Video to GIF Converter (Bash & FFmpeg)

A Linux/macOS-optimized Bash script that converts video files (optimized for `.mkv`) into high-quality GIFs using **FFmpeg** and a two-pass color palette generation technique.

## Features
* **Auto-Detection**: Automatically picks the first `.mkv` file in the script's folder if no input filename is provided.
* **Smart Palette Generation**: Uses FFmpeg's `palettegen` and `paletteuse` filters for optimal color accuracy.
* **Customizable Resolution**: Allows you to scale the width while automatically preserving the original aspect ratio.
* **Adjustable Framerate**: Control the FPS to manage the final output file size.
* **Clean Execution**: Automatically switches location to the script's home directory and removes temporary palette files after processing.

## Prerequisites
1. **Bash**: Available by default on Linux and macOS.
2. **FFmpeg**: Must be installed and available on your system's `PATH`.
   * To verify, open a terminal and run: `ffmpeg -version`
   * Install on Debian/Ubuntu: `sudo apt install ffmpeg`
   * Install on macOS (Homebrew): `brew install ffmpeg`

## Installation & Setup
1. Place `gif_converter.sh` into the folder containing the videos you want to convert.
2. Make the script executable:
   ```bash
   chmod +x gif_converter.sh
   ```

## How to Use
1. Run it from an active terminal:
   ```bash
   ./gif_converter.sh
   ```

2. Follow the interactive prompts:
   * **Input file**: Press `Enter` to auto-select the first `.mkv` file found, or type a specific filename.
   * **Output file**: Press `Enter` for an automatic name (`input_name.gif`) or type a custom name.
   * **FPS**: Press `Enter` for the default (`10`) or input your own framerate.
   * **Width**: Press `Enter` to keep the original size, or type a custom pixel width (e.g., `480`).
