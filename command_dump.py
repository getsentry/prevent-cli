#!/usr/bin/env python3
import subprocess


def command_dump(commands: list[str], out_path: str):
    print(f"Dumping {' '.join(commands)}")
    command_docs = subprocess.run(
        [*commands, "--help"], capture_output=True
    ).stdout.decode("utf-8")

    split_docs = command_docs.split("\n")

    try:
        index_of = split_docs.index("Commands:")
    except ValueError:
        return command_docs

    if "Commands:" in split_docs:
        sub_commands = [
            sub_command.strip()
            for sub_command in split_docs[index_of + 1 :]
            if sub_command.strip()
        ]
        for sub_command in sub_commands:
            command_docs = "\n".join(
                [command_docs, command_dump([*commands, sub_command], out_path)]
            )

    with open(out_path, "w") as f:
        f.write(command_docs)


if __name__ == "__main__":
    try:
        subprocess.check_call(["codecovcli", "--help"], stdout=subprocess.DEVNULL)
    except Exception:
        print(
            "codecovcli is not executable. You can install it with uv sync --project codecov-cli"
        )
        exit(1)

    try:
        subprocess.check_call(
            ["sentry-prevent-cli", "--help"], stdout=subprocess.DEVNULL
        )
    except Exception:
        print(
            "sentry-prevent-cli is not executable. You can install it with uv sync --project prevent-cli"
        )
        exit(1)

    command_dump(["codecovcli"], "codecov-cli/codecovcli_commands")
    command_dump(["sentry-prevent-cli"], "prevent-cli/preventcli_commands")
