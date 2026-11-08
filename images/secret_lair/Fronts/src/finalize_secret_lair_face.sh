#!/bin/sh
set -eu

src_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
set_dir=$(dirname -- "$src_dir")
base="$src_dir/secret_lair_category_imagegen_v1_unmodified.png"
logo_source="$src_dir/official_2025_winter_superdrop_hero.webp"
final="$set_dir/secret_lair_category_alternate_art_vault_v1_1800x2100.png"
preview="$src_dir/secret_lair_category_alternate_art_vault_v1_drawer_preview_300x350.png"

# The source generation is 1163x1353, only three pixels wider than exact 6:7.
# Crop the center to 1160x1353, resize, darken the existing central wordmark
# beneath a finely framed plaque, then overlay the exact official Wizards logo
# cut from the untouched 2025 hero. The logo spans 1450 px, or 91% of the
# 1600-px print-safe title band.
ffmpeg -hide_banner -loglevel error -y \
  -i "$base" \
  -i "$logo_source" \
  -filter_complex "\
    [0:v]crop=1160:1353:1:0,scale=1800:2100:flags=lanczos,eq=contrast=1.035:saturation=1.035,\
    drawbox=x=70:y=492:w=1660:h=1116:color=0x030304@1.0:t=fill,\
    drawbox=x=70:y=492:w=1660:h=1116:color=0xB87E2A@1.0:t=8,\
    drawbox=x=92:y=514:w=1616:h=1072:color=0xDFB469@0.88:t=3,\
    drawgrid=width=360:height=360:thickness=2:color=0x73501F@0.11[base];\
    [1:v]crop=450:326:735:96,format=rgba,colorkey=0x000000:0.19:0.08,scale=1450:-1:flags=lanczos[logo];\
    [base][logo]overlay=(W-w)/2:(H-h)/2:format=auto,format=rgb24[out]" \
  -map "[out]" -frames:v 1 -c:v png -dpi 600 "$final"

ffmpeg -hide_banner -loglevel error -y \
  -i "$final" -vf "scale=300:350:flags=lanczos" \
  -frames:v 1 -c:v png "$preview"

printf '%s\n%s\n' "$final" "$preview"
