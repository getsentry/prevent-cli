#!/bin/sh
apt install build-essential
cd codecov-cli
pip install uv pyinstaller
uv sync
pyinstaller --copy-metadata codecov-cli -F codecov_cli/main.py
cp ./dist/main ./dist/codecovcli_$1
