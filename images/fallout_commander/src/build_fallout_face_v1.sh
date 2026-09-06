#!/bin/zsh
set -euo pipefail

setdir="$(cd "$(dirname "$0")/.." && pwd)"
background="$setdir/src/fallout_commander_imagegen_key_art_adaptation_v1_unmodified.png"
official_logo="$setdir/src/pip_alg_en/MTGPIP_SetLogo_2C_white_en.png"
output="$setdir/fallout_commander_official_power_armor_key_art_target_v1_1800x2100.png"

# The source generation is already almost exactly 6:7. Scale by height and
# center-crop the roughly five surplus horizontal pixels after upscaling.
# Crop the two official lockup tiers separately so FALLOUT can own the drawer
# width while Magic / Universes Beyond remains clearly secondary.
ffmpeg -hide_banner -loglevel error -y \
  -i "$background" \
  -i "$official_logo" \
  -filter_complex \
  "[0:v]scale=-1:2100:flags=lanczos,crop=1800:2100:(iw-ow)/2:0[bg]; \
   [1:v]crop=510:220:195:187,scale=1600:-1:flags=lanczos[fallout]; \
   [1:v]crop=510:165:195:20,scale=720:-1:flags=lanczos[magic]; \
   [bg][fallout]overlay=100:55:format=auto[title]; \
   [title][magic]overlay=70:H-h-70:format=auto[out]" \
  -map "[out]" -frames:v 1 -pix_fmt rgba "$output"

sips -s dpiWidth 600 -s dpiHeight 600 "$output" --out "$output" >/dev/null
echo "Wrote $output"
