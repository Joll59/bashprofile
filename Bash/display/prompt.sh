#!/bin/bash
# Configuring Our Prompt
# ======================

# if you install git via homebrew, or install the bash autocompletion via homebrew, you get __git_ps1 which you can use in the PS1
# to display the git branch.  it's supposedly a bit faster and cleaner than manually parsing through sed. i dont' know if you care
# enough to change it

# This function is called in your prompt to output your active git branch.
function parse_git_branch() {
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# This function builds your prompt. It is called below
function prompt() {
    # Define the prompt character
    local CHAR="☆"
    local CHAR2="♛"

    # Define some local colors
    local RED="\[\e[0;31m\]"
    local BLUE="\[\e[0;34m\]"
    local GREEN="\[\e[0;32m\]"
    local GRAY_TEXT_BLUE_BACKGROUND="\[\e[37;44;1m\]"

    # Define a variable to reset the text color
    local RESET="\[\e[0m\]"

    # ♥ //  ♔ ☆ - Keeping some ASCII Characters for reference

    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    export PS1="\\[\e]2;\u@\h\a[$RED\t$RESET]$RED\$(parse_git_branch) $GREEN\W $BLUE//$RED $CHAR $BLUE ⇶ $RED $CHAR2 $RESET ⇰ "
    PS1='$(printf "%$((COLUMNS-1))s\r")'$PS1
    PS2='continue->'
    PS4='+ '
}

# For more prompt changes, check out Halloween Bash:
# http://xta.github.io/HalloweenBash/

# Finally call the function and our prompt is all pretty
prompt
