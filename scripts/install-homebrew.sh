#!/usr/bin/env bash
#
# Install Homebrew
#
# Ensure that Homebrew and desired formulae are installed and up-to-date.
#

# Exit immediately if a command exits with a nonzero exit status.
set -e

# Work out of a known location.
# Reference: http://stackoverflow.com/a/246128
directory_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${directory_root}"

. ./common.sh

# Bail out if we're not running macOS.
if [[ $OSTYPE != darwin* ]]; then
    exit 0
fi

# Ensure that Homebrew is installed.
hash brew 2>/dev/null || {
    info "Installing Homebrew..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    success "Done installing Homebrew."
}

# Make sure we're using the latest Homebrew formulae.
info "› brew update"
brew update
success "Done."

# Upgrade any already-installed formulae.
info "› brew upgrade"
brew upgrade --ignore-pinned
success "Done."

# Install some useful/fun formulae.
info "› brew install ..."
brew install \
    awscli \
    cowsay \
    figlet \
    findutils \
    fortune \
    fzf \
    git \
    git-lfs \
    gmp \
    gnu-sed \
    gnupg \
    grep \
    hub \
    imagemagick \
    links \
    lolcat \
    lorem \
    moreutils \
    node \
    openssh \
    p7zip \
    pigz \
    pv \
    python3 \
    rename \
    rlwrap \
    s3cmd \
    screen \
    ssh-copy-id \
    telnet \
    toilet \
    tree \
    vbindiff \
    vim \
    watchman \
    wget \
    xz \
    youtube-dl \
    zopfli
success "Done."

# Install some CTF tools.
# Reference: https://github.com/ctfs/write-ups
#info "› brew install ... (CTF)"
#brew install \
#    aircrack-ng \
#    bfg \
#    binutils \
#    binwalk \
#    cifer \
#    dex2jar \
#    dns2tcp \
#    fcrackzip \
#    foremost \
#    hashpump \
#    hydra \
#    john \
#    knock \
#    netpbm \
#    nmap \
#    pngcheck \
#    socat \
#    sqlmap \
#    tcpflow \
#    tcpreplay \
#    tcptrace \
#    ucspi-tcp \
#    xpdf
#success "Done."

# Remove outdated files.
info "› brew cleanup"
brew cleanup
success "Done."
