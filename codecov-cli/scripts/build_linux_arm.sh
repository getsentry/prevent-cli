#!/bin/sh
apt install build-essential
cd codecov-cli
pip install uv pyinstaller
uv sync
pyinstaller main.spec
cp ./dist/main ./dist/codecovcli_$1
