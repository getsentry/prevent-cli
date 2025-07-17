#!/bin/sh
set -eux
apk add build-base python3 py3-pip curl
curl --proto '=https' --tlsv1.2 -LsSf https://github.com/astral-sh/uv/releases/download/0.7.8/uv-installer.sh > uv-installer.sh
# Added sanity check file has not been tampered with
if sha256sum -c ./scripts/uv-installer-0.7.8.sha256sum; then
    sh uv-installer.sh; else
    echo "uv-installer failed checksum" && exit 1
fi
cd prevent-cli
/root/.local/bin/uv python pin 3.9 # we need to build with python 3.9 to support systems with libpython >= 3.9
/root/.local/bin/uv sync
/root/.local/bin/uv run pyinstaller -F src/prevent_cli/main.py
mv ./dist/main ./dist/sentry-prevent-cli_$1

cd ../codecov-cli
/root/.local/bin/uv run pyinstaller -F codecov_cli/main.py
mv ./dist/main ./dist/codecovcli_$1
