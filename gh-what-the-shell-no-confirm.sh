copilot_what-the-shell-no-confirm () {
  os=$(uname)

  if ! which expect > /dev/null; then
      echo -e "⚠  expect is not installed.\n"
      case "$os" in
          Linux)
              if [ -f /etc/debian_version ]; then
                  echo "For Ubuntu/Debian, you can install expect with:"
                  echo "  sudo apt install expect"
              elif [ -f /etc/redhat-release ]; then
                  echo "For CentOS/Fedora/RHEL, you can install expect with:"
                  echo "  sudo yum install expect"
              else
                  echo "Please refer to their wiki for installation instructions:"
                  echo "  https://core.tcl-lang.org/expect/file?name=INSTALL"
              fi
              ;;
          Darwin)
              echo "For macOS, you can install expect with Homebrew:"
              echo "  brew install expect"
              ;;
          *)
              echo "Please refer to their wiki for installation instructions:"
                echo "  https://core.tcl-lang.org/expect/file?name=INSTALL"
              ;;
      esac
      return 1
  fi

  args_to_pass_down=${@}

  # this is ripped off from the original ?? alias definition,
  # after the command is generated by the AI it's firts written
  # to a temp file, and then later executed and written to history.
  tmp_cmd_file=$(mktemp);
  trap 'rm -f $tmp_cmd_file' EXIT;

  # Run the command with the given arguments, while automatically
  # providing 'y' to stdin when the confirmation prompt appears.
  expect -c "
    exp_internal 0
    log_user 1

    spawn -noecho bash -c \
      \"github-copilot-cli what-the-shell $args_to_pass_down --shellout $tmp_cmd_file \"

    expect_background {

      # Detect/expect the confirmation prompt
      \"Are you sure? (y/N)\" {
        send \"y\"
        exp_continue
      }

      # Detect/expect eof (command exiting), and exit gracefully
      eof {
        exit
      }
    }

    # Since the expect_background loop is non-blocking, we want to
    # enable interaction with the github-copilot-cli.
    interact
  "

  # This if/else is ripped off from the original ?? alias definition.
  if [ -s "$tmp_cmd_file" ]; then
      cmd_itself=$(cat $tmp_cmd_file);

      case "$(basename $SHELL)" in
        bash|ksh|tcsh)
          history -s $(history 1 | cut -d' ' -f4-);
          history -s "$cmd_itself";
          ;;
        zsh)
          print -s "$cmd_itself";
          ;;
      esac

      eval "$cmd_itself";
  fi
}

# override the stock ?? alias...
alias '??'='copilot_what-the-shell-no-confirm'
