#!/bin/bash

echo ---------------------------------------------
echo - Starting Amethyst git clone...
echo ---------------------------------------------

git clone https://github.com/amethyst/amethyst.git
cd amethyst

echo ---------------------------------------------
echo - Moving to latest stable release
echo ---------------------------------------------

git fetch --tags
latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
git checkout $latestTag

echo ---------------------------------------------
echo - Preping Rust...
echo ---------------------------------------------

rustup default stable
cargo install mdbook

echo ---------------------------------------------
echo - Generating Stable Book...
echo ---------------------------------------------

mdbook build book

echo ---------------------------------------------
echo - Generating Stable API...
echo ---------------------------------------------

cargo doc --features="vulkan"

echo ---------------------------------------------
echo - Moving stable API and Book to public...
echo ---------------------------------------------

pwd

# Makes docs.amethyst.rs/book/latest
echo copying book...
mkdir -p ../public/book/stable
cp -r book/book/* ../public/book/stable/

# Makes docs.amethyst.rs/api/latest
echo copying api...
mkdir -p ../public/api/stable
cp -r target/doc/* ../public/api/stable/

echo ---------------------------------------------
echo - Moving to latest main
echo ---------------------------------------------

git checkout main

echo ---------------------------------------------
echo - Generating Latest Book...
echo ---------------------------------------------

mdbook build book

echo ---------------------------------------------
echo - Generating Latest API...
echo ---------------------------------------------

cargo doc --features="vulkan"

echo ---------------------------------------------
echo - Moving Latest API and Book to public...
echo ---------------------------------------------

pwd

# Makes docs.amethyst.rs/book/latest
echo copying book...
mkdir -p ../public/book/latest
cp -r book/book/* ../public/book/latest/

# Makes docs.amethyst.rs/api/latest
echo copying api...
mkdir -p ../public/api/latest
cp -r target/doc/* ../public/api/latest/

echo Done...