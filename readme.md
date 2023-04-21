# GitHub Copilot CLI's `what-the-shell` but without the confirmation

This script is designed to automate the process of accepting the confirmation prompt when using the [GitHub Copilot CLI's](https://www.npmjs.com/package/@githubnext/github-copilot-cli) `what-the-shell` command (i.e. the `??` alias).

I wish they had a CLI flag like `--no-confirm`/`-y` or something like that, but they don't.

## Prerequisites

- `expect` must be installed on your system. 
    - **Ubuntu/Debian:** If you are using Ubuntu or Debian, you can install `expect` with the following command: `sudo apt install expect`
    - **CentOS/Fedora/RHEL:** If you are using CentOS, Fedora, or Red Hat Enterprise Linux (RHEL), you can install `expect` with the following command: `sudo yum install expect`
    - **macOS:** If you are using macOS, you can install `expect` with Homebrew: `brew install expect`
    - **Other Operating Systems:** If you are using a different operating system, please refer to the [Expect Wiki](https://core.tcl-lang.org/expect/file?name=INSTALL) for installation instructions.

- The GitHub Copilot CLI must be installed and configured on your system.

## Installation

1. Copy the script to your preferred location (for me just `~/`)

    ```bash
    wget https://raw.githubusercontent.com/martin-podlubny/gh-copilot-cli-no-confirm/main/gh-what-the-shell-no-confirm.sh -O ~/gh-what-the-shell-no-confirm.sh
    ```

2. Source the script in your shell configuration file (e.g. `~/.bashrc` or `~/.zshrc`) after the GitHub Copilot CLI's own setup, like:
    
    ```bash
    # GitHub Copilot CLI setup
    eval "$(github-copilot-cli alias -- "$0")"

    # GitHub Copilot CLI's `what-the-shell` but without the confirmation
    source ~/gh-what-the-shell-no-confirm.sh
    ```

## Usage

Your `??` should now behave almost like the original `??`, but when you choose to _"✅ Run this command"_ it will just happen without the annoying prompt _"Are you sure? (y/N)"_. 

I already chose the run command option, so I'm sure enough 😛
