#!/bin/sh
apk add build-base
cd codecov-cli
pip install uv
uv sync
uv add --dev pyinstaller
uv run pyinstaller -F codecov_cli/main.py
cp ./dist/main ./dist/codecovcli_$1
