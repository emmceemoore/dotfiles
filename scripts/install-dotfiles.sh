#!/usr/bin/env bash
#
# Install Dotfiles
#
# Configure and copy over dotfiles to the user's $HOME directory.
#

# Exit immediately if a command exits with a nonzero exit status.
set -e

# Work out of a known location.
# Reference: http://stackoverflow.com/a/246128
directory_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${directory_root}"

. ./common.sh

### Functions ###

setupGitconfigLocal() {
    # Configure `.gitconfig.local` if necessary.
    if ! [ -f "${dotfiles_dir}/.gitconfig.local" ]; then
        info "Setting up .gitconfig.local..."

        user " - What name would you like to use for git?"
        read -e git_user_name
        user " - What email would you like to use for git?"
        read -e git_user_email

        sed \
            -e "s/USER_NAME/${git_user_name}/g" \
            -e "s/USER_EMAIL/${git_user_email}/g" \
            "${dotfiles_dir}/.gitconfig.local.example" \
        > "${dotfiles_dir}/.gitconfig.local"

        success "Done setting up .gitconfig.local."
    fi
}

linkFile() {
    local src=$1
    local dst=$2

    if [ -L "${dst}" ]; then
        unlink "${dst}"
        success "Unlinked ${dst}"
    fi
    if [ -f "${dst}" -o -d "${dst}" ]; then
        mv "${dst}" "${dst}.bkup"
        success "Moved ${dst} to ${dst}.backup"
    fi
    ln -s "${src}" "${dst}"
    success "Linked ${src} to ${dst}"
}

### Main ###

# Symlink paths are nicer if we work out of the project root.
dotfiles_dir="$(dirname "${directory_root}")"
cd "${dotfiles_dir}"

setupGitconfigLocal
linkFile "${dotfiles_dir}/.gitconfig.local" "${HOME}/.gitconfig.local"
linkFile "${dotfiles_dir}/.gitconfig" "${HOME}/.gitconfig"
linkFile "${dotfiles_dir}/gitignore" "${HOME}/.gitignore"
linkFile "${dotfiles_dir}/.terminal-themes" "${HOME}/.terminal-themes"
linkFile "${dotfiles_dir}/.vimrc" "${HOME}/.vimrc"
linkFile "${dotfiles_dir}/.zshrc" "${HOME}/.zshrc"
linkFile "${dotfiles_dir}/.fzf.zsh" "${HOME}/.fzf.zsh"
