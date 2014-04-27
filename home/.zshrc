source ~/.zsh/common.zsh
source ~/.zsh/prompt.zsh

fpath=(~/.zsh/functions $fpath)

# Source every file that contains aliases from ~/.zsh/aliases.
for file in ~/.zsh/aliases/*.zsh; do
  source $file
done
