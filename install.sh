#!/usr/bin/env bash

if ! [ -e .git ]; then
    echo "Please run this from repo root directory"
    exit 1
fi

cd .git/hooks
for i in pre-commit; do
    rm -fv $i
    ln -sv ../../hooks/$i
done

if ! type 'uv' >/dev/null 2>/dev/null; then
    echo "uv executable not found in your \$PATH. You can install with \`pip install uv\` or by using your system's package manager."
fi
