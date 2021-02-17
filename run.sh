#!/bin/bash

echo ---------------------------------------------
echo - Starting Amethyst git clone...
echo ---------------------------------------------

git clone https://github.com/amethyst/amethyst.git

cd amethyst

echo ---------------------------------------------
echo - Moving to latest branch
echo ---------------------------------------------

git fetch --tags

latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag


echo ---------------------------------------------
echo - Preping rust...
echo ---------------------------------------------

rustup default stable

cargo install mdbook
mdbook build book

echo Done...
# From here Netlify grabs amethyst/book/book and host it...