#!/bin/sh
set -eux
apt update
DEBIAN_FRONTEND=noninteractive apt install -y tzdata
apt install -y python3.9 python3.9-dev python3-pip
cd prevent-cli
python3.9 -m pip install uv --only-binary uv
uv python pin 3.9 # we need to build with python 3.9 to support systems with libpython >= 3.9
uv sync
uv run pyinstaller -F src/prevent_cli/main.py
mv ./dist/main ./dist/sentry-prevent-cli_$1
cd ../codecov-cli
uv run pyinstaller -F codecov_cli/main.py
mv ./dist/main ./dist/codecovcli_$1

# linux binary should be just codecovcli_linux
if [ $1 = "linux_x86_64" ]; then
    cd ..
    mv ./prevent-cli/dist/sentry-prevent-cli_$1 ./prevent-cli/dist/sentry-prevent-cli_linux
    mv ./codecov-cli/dist/codecovcli_$1 ./codecov-cli/dist/codecovcli_linux
fi
