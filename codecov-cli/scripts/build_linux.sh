#!/bin/sh
apt update
apt install -y build-essential python3 python3-pip
cd codecov-cli
pip install uv
uv sync
uv add --dev pyinstaller
uv run pyinstaller -F codecov_cli/main.py
mv ./dist/main ./dist/codecovcli_$1

# linux binary should be just codecovcli_linux
if [ $1 = "linux_x86_64" ]; then
    mv ./dist/codecovcli_$1 ./dist/codecovcli_linux
fi
