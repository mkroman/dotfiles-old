for file in $HOME/.zsh/hooks/*.zsh; do
  source $file
done

# Print a grey ¬ when trying to preserve a partial line.
export PROMPT_EOL_MARK="%F{59}¬%f"

# Set the left part of the prompt.
export PROMPT="%F{cyan}%n@%m%f %~ %# "

# Set the right part of the prompt.
#
# Available variables that are provided by hooks:
# $_git_branch - shows the name of the current git branch.
export RPROMPT="\$_git_branch"
