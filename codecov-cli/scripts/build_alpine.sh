#!/bin/sh
apk add build-base python3 py3-pip curl
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/astral-sh/uv/releases/download/0.7.8/uv-installer.sh > uv-installer.sh
# Added sanity check file has not been tampered with
echo "3e3043ca08e1156fbe18d90a1a4def3ae795418857c8f4ed3f807ffc45e51c3d  uv-installer.sh" > uv-installer.sh.SHA256SUM
if sha256sum -c uv-installer.sh.SHA256SUM; then
    sh uv-installer.sh
fi
cd codecov-cli
/root/.local/bin/uv python pin 3.9
/root/.local/bin/uv sync
/root/.local/bin/uv add --dev pyinstaller
/root/.local/bin/uv run pyinstaller -F codecov_cli/main.py
mv ./dist/main ./dist/codecovcli_$1
