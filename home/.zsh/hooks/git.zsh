# Finds and sets the current repository git branch.

precmd_git_find_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    _git_branch="($branch)"
  else
    _git_branch=""
  fi
}

add-zsh-hook precmd precmd_git_find_branch
