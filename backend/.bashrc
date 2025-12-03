# Custom .bashrc for Nexuss Bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set PS1 to mimic a Termux/Linux prompt with a green user/host and white path
PS1='\[[1;32m\]\u@NexussBash\[[0m\]:\[[1;37m\]\w\[[0m\]$ '

# Alias for 'clear' to also reset the terminal state
alias clear='clear && printf "[3J"'

# Welcome message
echo -e "
[1;32mWelcome to Nexuss Bash[0m"
echo -e "Type 'help' for assistance.
"
