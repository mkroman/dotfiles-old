for file in $HOME/.zsh/hooks/*.zsh; do
  source $file
done

export PS1="%{$fg[cyan]%}%n@%m%b%{$fg[normal]%} %~ \$_git_branch
%# "
