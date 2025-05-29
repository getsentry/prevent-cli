#!/bin/sh
apt update
DEBIAN_FRONTEND=noninteractive apt install -y tzdata
apt install -y python3.9 python3.9-dev python3-pip
cd codecov-cli
python3.9 -m pip install uv --only-binary uv
uv python pin 3.9
uv sync
uv add --dev pyinstaller
uv run pyinstaller -F codecov_cli/main.py
mv ./dist/main ./dist/codecovcli_$1

# linux binary should be just codecovcli_linux
if [ $1 = "linux_x86_64" ]; then
    mv ./dist/codecovcli_$1 ./dist/codecovcli_linux
fi
