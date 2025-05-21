#!/bin/sh
cd codecov-cli
#apt install build-essential
pip install uv pyinstaller
uv sync
pyinstaller --copy-metadata codecov-cli -F codecov_cli/main.py
cp ./dist/main ./dist/codecovcli_$1
