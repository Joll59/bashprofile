#!/bin/bash
#   ---------------------------
#   SEARCHING
#   ---------------------------

alias fhere="find . -name "              # fhere:    Quickly search for file in current directory

alias histg="history | grep"

#   ---------------------------
#   PROCESS MANAGEMENT
#   ---------------------------

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
alias memHogsTop='top -l 1 -o rsize | head -20'

alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
alias ttop="top -R -F -s 10 -o rsize"

#  psg: fuzzy search for particular process by name: psg "process name"
#   ------------------------------------------------------------
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

# NETWORKING
#   ------------------------------------------------------------
alias myip="curl http://ipecho.net/plain; echo"

# Aliases
# =====================
# LS
alias l='ls -lah'
alias ll='ls -alF'
alias lv='ls -1a'
alias la='ls -A'
alias l='ls -CF'
alias ls1='tree -L 1'
alias ls2='tree -L 2'
alias ls3='tree -L 3'
alias lss='ls -la'
#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#Navigation
alias c="clear"                  # c:            Clear terminal display
alias ..="cd .."                 # Go back 1 directory level
alias ...='cd ../../'            # Go back 2 directory levels
alias .3='cd ../../../'          # Go back 3 directory levels
alias .4='cd ../../../../'       # Go back 4 directory levels
alias .5='cd ../../../../../'    # Go back 5 directory levels
alias .6='cd ../../../../../../' # Go back 6 directory levels
alias ~="cd ~"                   # ~:            Go Home

#Make Basher better
alias which='type -all'                   # which:        Find executables

alias path='echo -e ${PATH//:/\\n}'       # path:         Echo all executable Paths

alias show_options='shopt'                # Show_options: display bash options settings

alias fix_stty='stty sane'                # fix_stty:     Restore terminal settings when screwed up

# Case-Insensitive Auto Completion
bind "set completion-ignore-case on" 2>/dev/null

alias cic='set completion-ignore-case On' # cic:          Make tab-completion case-insensitive

alias DT='tee ~/Desktop/terminalOut.txt'  # DT:           Pipe content to file on MacOS Desktop
alias numFiles='echo $(ls -1 | wc -l)'    # numFiles:     Count of non-hidden files in current dir

# Git
alias gcl="git clone"
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gd="git diff | atom-beta"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gb="git branch"
alias gba="git branch -a"
alias gcam="git commit -am"
alias gbb="git branch -b"
alias gitgetlines="git ls-files | xargs cat | wc -l"

# RSPEC
alias tspec="rspec --f-f"
alias hspec="rspec -f h > spec_failed_tests.html; open spec_failed_tests.html"

#alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
