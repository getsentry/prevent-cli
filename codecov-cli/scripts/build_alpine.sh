#!/bin/sh
apk add build-base python3 py3-pip
cd codecov-cli
python3.9 -m pip install uv
uv python pin 3.9
uv sync
uv add --dev pyinstaller
uv run pyinstaller -F codecov_cli/main.py
mv ./dist/main ./dist/codecovcli_$1
