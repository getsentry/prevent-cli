#!/bin/bash
set -eux
# $1 is the old version but we don't need it
NEW_VERSION="${2}" 

# update package versions
sed -i "s/version\ =\ \"[0-9]\+.[0-9]\+.[0-9]\+\"/version\ =\ \"$NEW_VERSION\"/g" codecov-cli/pyproject.toml prevent-cli/pyproject.toml
# update codecov-cli dependency version in prevent-cli
sed -i "s/codecov-cli==[0-9]\+.[0-9]\+.[0-9]\+/codecov-cli==$NEW_VERSION/g" prevent-cli/pyproject.toml

pip install uv
# updates uv.locks
uv sync --project codecov-cli 
uv sync --project prevent-cli
