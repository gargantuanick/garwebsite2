#!/usr/bin/env bash
set -euo pipefail

# Optimize a team member photo into multiple sizes and formats.
# Usage: tools/optimize-images.sh images/team/jieen-chen.jpg

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <input-jpg> [base-name]" >&2
  exit 1
fi

in="$1"
if [[ ! -f "$in" ]]; then
  echo "Input file not found: $in" >&2
  exit 1
fi

# Determine output base without extension, or use provided base name
base_noext="${2:-${in%.*}}"
dir="$(dirname "$base_noext")"
name="$(basename "$base_noext")"
mkdir -p "$dir"

# Target widths and quality
widths=(400 800)
jpeg_quality=78
webp_quality=80

have_sips=false
have_magick=false
have_cwebp=false
command -v sips >/dev/null 2>&1 && have_sips=true
command -v magick >/dev/null 2>&1 && have_magick=true
command -v convert >/dev/null 2>&1 && { magick() { convert "$@"; }; have_magick=true; }
command -v cwebp >/dev/null 2>&1 && have_cwebp=true

echo "Optimizing $in -> $dir/$name-{${widths[*]}}w.{jpg,webp}"

for w in "${widths[@]}"; do
  out_jpg="$dir/$name-${w}w.jpg"
  out_webp="$dir/$name-${w}w.webp"

  if $have_sips; then
    # Resize and compress JPEG with sips
    sips -s format jpeg -s formatOptions $jpeg_quality --resampleWidth $w "$in" --out "$out_jpg" >/dev/null
  elif $have_magick; then
    magick "$in" -filter Lanczos -resize ${w}x -strip -sampling-factor 4:2:0 -interlace Plane -quality $jpeg_quality "$out_jpg"
  else
    echo "WARN: Neither sips nor ImageMagick found; copying original as $out_jpg" >&2
    cp "$in" "$out_jpg"
  fi

  if $have_cwebp; then
    cwebp -quiet -q $webp_quality "$out_jpg" -o "$out_webp" >/dev/null
  elif $have_magick; then
    magick "$out_jpg" -quality $webp_quality "$out_webp"
  else
    echo "WARN: Neither cwebp nor ImageMagick found; skipping WebP for width $w" >&2
  fi
done

echo "Done. Generated files:"
ls -lh "$dir"/"$name"-*w.* 2>/dev/null || true

