#!/usr/bin/env bash
#
# Install Build Tools
#

# Exit immediately if a command exits with a nonzero exit status.
set -e

# Work out of a known location.
# Reference: http://stackoverflow.com/a/246128
directory_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${directory_root}"

. ./common.sh

if [[ $OSTYPE == darwin* ]]; then
    ### Install macOS-specific dependencies. ###

    # Ensure that Xcode command line tools are installed. (We assume this to be
    # the case if `gcc` is present in the default location.)
    if ! [ -f /Applications/Xcode.app/Contents/Developer/usr/bin/gcc ]; then
        info "Installing command line tools..."
        xcode-select --install
        success "Done installing command line tools."
    fi
else
    ### Install Linux-specific dependencies. ###

    # We assume that we're on a version of Linux that uses `apt`.

    info "Updating/Upgrading system packages..."
    apt-get update
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
    success "Done updating/upgrading system packages."

    info "Installing \"buildpack\" dependencies..."
    apt-get \
        install -y --no-install-recommends \
            autoconf \
            automake \
            bzip2 \
            ca-certificates \
            curl \
            file \
            g++ \
            gcc \
            git \
            imagemagick \
            libbz2-dev \
            libc6-dev \
            libcurl4-openssl-dev \
            libevent-dev \
            libffi-dev \
            libgeoip-dev \
            libglib2.0-dev \
            libjpeg-dev \
            liblzma-dev \
            libmagickcore-dev \
            libmagickwand-dev \
            libmysqlclient-dev \
            libncurses-dev \
            libpng-dev \
            libpq-dev \
            libreadline-dev \
            libsqlite3-dev \
            libssl-dev \
            libtool \
            libwebp-dev \
            libxml2-dev \
            libxslt-dev \
            libyaml-dev \
            make \
            patch \
            wget \
            xz-utils \
            zlib1g-dev
    success "Done installing \"buildpack\" dependencies."
fi
