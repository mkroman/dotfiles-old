#!/usr/bin/env zsh
# Copyright (c) 2014, Mikkel Kroman <mk@maero.dk>
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# Except as contained in this notice, the name(s) of the above
# copyright holders shall not be used in advertising or otherwise to
# promote the sale, use or other dealings in this Software without prior
# written authorization.

# List of all our git repositories
git_repository_list() {
  find . -mindepth 2 -name .git -type d 2> /dev/null
}

# Find the remote origin url for a given repository
git_repository_origin() {
  GIT_DIR=$1 \
    git config --get remote.origin.url
}

# Add a git repository as a submodule
submodule_add() {
  remote_origin=$1
  submodule_path=$2

  git submodule add ${remote_origin} ${submodule_path} 2> /dev/null
}

echo "Adding submodules.."
echo

git_repositories=$(git_repository_list)

for repository in ${(f)git_repositories}; do
  submodule_name=${${repository:h}:t}
  repository_path=${(q)repository}
  remote_origin=$(git_repository_origin ${repository_path})

  echo "+ ${submodule_name}"
  echo "  (${remote_origin})"
  submodule_add ${(q)remote_origin} ${repository_path:h}
done

# vim: ft=sh
