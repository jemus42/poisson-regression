#! /bin/bash

# Do the font dance with Source Pro (all of them)
# Adapted from: https://gist.github.com/enzinier/8d00d3f37d2e23985dcfa65662d163fa

FONT_HOME="$HOME/.local/share/fonts"

echo "installing fonts at $PWD to $FONT_HOME"

echo "Downloading Fira fonts"
# Create directory to hold the fonts
mkdir -p "$FONT_HOME/fira"

# Download the fonts by cloning the repos (they're not *that* big)
(git clone \
  --branch master \
  --depth 1 \
  "https://github.com/bBoxType/FiraSans.git" \
  "$FONT_HOME/fira")

# Refresh font cache to make fonts available
# fc-cache -f -v "$FONT_HOME/adobe-fonts/source-$VARIANT-pro/TTF"
