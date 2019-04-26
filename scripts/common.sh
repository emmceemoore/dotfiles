#
# common.sh - Common code for use by other shell scripts.
#

### Helper functions to help with "logging". ###

info() {
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user() {
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ""
    exit -1
}
