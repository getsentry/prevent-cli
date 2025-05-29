#!/bin/sh
apk add build-base python3 py3-pip
cd codecov-cli
pip install uv --prefer-binary
uv sync
uv add --dev pyinstaller
uv run pyinstaller -F codecov_cli/main.py
mv ./dist/main ./dist/codecovcli_$1
