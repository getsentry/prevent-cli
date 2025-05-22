#!/bin/sh
apk add build-base
cd codecov-cli
pip install uv
uv sync
uv add --dev pyinstaller
uv run pyinstaller main.spec
cp ./dist/main ./dist/codecovcli_$1
