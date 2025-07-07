#!/bin/bash
set -eux
# $1 is the old version but we don't need it
NEW_VERSION="${2}" 

sed -i "s/version\ =\ \"[0-9]\+\.[0-9]\+\.[0-9]\+\"/version\ =\ \"$NEW_VERSION\"/g" codecov-cli/pyproject.toml
pip install uv
uv sync --project codecov-cli # updates uv.lock
uv sync --project prevent-cli
