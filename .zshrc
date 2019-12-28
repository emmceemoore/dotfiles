#
# ZSH Configuration
#

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    aws
    brew
    chucknorris
    colored-man-pages
    command-not-found
    #common-aliases
    django
    gatsby
    git
    #git-extras
    gnu-utils
    history
    node
    npm
    pip
    pj
    python
    rand-quote
    safe-paste
    screen
    swiftpm
    vi-mode
    web-search
)

source $ZSH/oh-my-zsh.sh

### User Configuration ###

unsetopt share_history
bindkey '^R' history-incremental-search-backward

#
# fzf
#

set -o vi

# Setup fzf
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS="--layout=reverse --inline-info --multi"

#
# Exports
#

export PATH="${HOME}/bin:/usr/local/sbin:${PATH}"

# Opt out of Homebrew analytics.
export HOMEBREW_NO_ANALYTICS=1

# Replace the "beer" emoji with something else.
export HOMEBREW_INSTALL_BADGE="🥳"

# Make vim the default editor.
export EDITOR="vim"

# Exclude some files by default.
export GREP_OPTIONS="--exclude=*.pyc --exclude-dir=.git"

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history
# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE="32768"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING="UTF-8"

# Increase Bash history size. Allow 32³ entries; the default is 500.
export HISTSIZE="32768"
export HISTFILESIZE="${HISTSIZE}"
# Omit duplicates and commands that begin with a space from history.
export HISTCONTROL="ignoreboth"

# Prefer US English and use UTF-8.
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Highlight section titles in manual pages.
export LESS_TERMCAP_md="${yellow}"

# Don't clear the screen after quitting a manual page; skip the pager if the
# content fits on the screen.
export MANPAGER="less -F -X"

# Don't clear the screen after quitting a git command; skip the pager if the
# content fits on the screen.
export GIT_PAGER="less -F -X"

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty)

#
# Aliases
#

# Easier Navigation: .., ..., ...., ....., and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

# Safer Defaults
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Shortcuts
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias df="cd $(dirname $(readlink ~/.zshrc))"

# Keystroke Savers
alias cls="clear"
alias claer="clear"

# `ls`
alias l="ls -l"
alias la="ls -la"

# Print each `PATH` entry on a separate line.
alias path='echo -e ${PATH//:/\\n}'

# IP Addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache.
alias flush-dns="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the "Open With" menu.
alias fix-open-with="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Canonical hex dump (some systems have this symlinked).
command -v hd > /dev/null || alias hd="hexdump -C"

# PlistBuddy alias, because sometimes `defaults` just doesn't cut it.
alias plistbuddy="/usr/libexec/PlistBuddy"

# Basic volume controls.
# http://xkcd.com/530/
alias volume-off="osascript -e 'set volume output muted true'"
alias volume-max="osascript -e 'set volume output volume 100'"

# Improved is better.
alias vi="vim"

# Start up a simple HTTP server rooted in the current directory.
alias simple-server="python -m SimpleHTTPServer 8001"

# Software Updates
alias brewup="brew update && brew upgrade --ignore-pinned && brew cleanup; brew doctor"
alias nodeup="npm install npm -g && npm update -g"
alias update="brewup && nodeup"

# Misc
alias cpr="hub pull-request"
alias hyperspace="say -v Zarvox 'hyperspace'"
alias prettyjson="python -m json.tool"
alias taco="curl -L git.io/taco"

### Functions ##################################################################

# Convenience function to move up directories.
u() {
    set -A ud
    ud[1+${1-1}]=
    cd ${(j:../:)ud}
}

### Prompt #####################################################################

# Display the full-ish path on the right.
RPROMPT="%{${fg[red]}%}%B%(7~,.../,)%6~%b%{${fg[default]}%}"
