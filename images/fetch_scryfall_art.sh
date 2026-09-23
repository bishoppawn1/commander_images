#!/bin/zsh
set -euo pipefail

if (( $# != 2 )); then
  print -u2 "Usage: fetch_scryfall_art.sh CARD_NAME OUTPUT_PATH"
  exit 1
fi

card_name="$1"
output_path="$2"
mkdir -p "${output_path:h}"

json="$(curl --fail --silent --show-error --get \
  --header 'User-Agent: MTGCommanderFaces/1.0' \
  --data-urlencode "exact=${card_name}" \
  'https://api.scryfall.com/cards/named')"

art_url="$(print -r -- "$json" | jq -r '.image_uris.art_crop // .card_faces[0].image_uris.art_crop // empty')"
if [[ -z "$art_url" ]]; then
  print -u2 "No art crop found for ${card_name}"
  exit 1
fi

curl --fail --silent --show-error --location \
  --header 'User-Agent: MTGCommanderFaces/1.0' \
  "$art_url" \
  --output "$output_path"
print "Wrote ${output_path}"
