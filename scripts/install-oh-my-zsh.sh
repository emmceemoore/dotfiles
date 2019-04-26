#!/usr/bin/env bash
#
# Install Oh-My-ZSH
#

# Exit immediately if a command exits with a nonzero exit status.
set -e

# Work out of a known location.
# Reference: http://stackoverflow.com/a/246128
directory_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${directory_root}"

. ./common.sh

# Ensure that oh-my-zsh is installed.
if ! [ -d ${HOME}/.oh-my-zsh ]; then
    info "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    success "Done installing oh-my-zsh."
fi
