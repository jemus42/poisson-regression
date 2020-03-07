#! /bin/bash

# Do the font dance with Source Pro (all of them)
# Adapted from: https://gist.github.com/enzinier/8d00d3f37d2e23985dcfa65662d163fa

FONT_HOME="$HOME/.local/share/fonts"

echo "installing fonts at $PWD to $FONT_HOME"

for VARIANT in serif sans source; do

  echo "Downloading Source >$VARIANT< Pro"
  # Create directory to hold the fonts
  mkdir -p "$FONT_HOME/adobe-fonts/source-$VARIANT-pro"

  # Download the fonts by cloning the repos (they're not *that* big)
  (git clone \
   --branch release \
   --depth 1 \
   "https://github.com/adobe-fonts/source-$VARIANT-pro.git" \
   "$FONT_HOME/adobe-fonts/source-$VARIANT-pro")

done

# Refresh font cache to make fonts available
fc-cache -f -v "$FONT_HOME/adobe-fonts"
