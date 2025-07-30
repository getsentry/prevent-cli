#!/bin/sh
# this updates the editable property on the codecov-cli import in prevent-cli 
# to be false. This is necessary for the pyinstaller build to work.
if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/editable\ =\ true/editable\ =\ false/g" prevent-cli/pyproject.toml
else
    sed -i "s/editable\ =\ true/editable\ =\ false/g" prevent-cli/pyproject.toml
fi
