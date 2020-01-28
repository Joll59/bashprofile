# Configuring Our Prompt
# ======================

  # if you install git via homebrew, or install the bash autocompletion via homebrew, you get __git_ps1 which you can use in the PS1
  # to display the git branch.  it's supposedly a bit faster and cleaner than manually parsing through sed. i dont' know if you care
  # enough to change it

  # This function is called in your prompt to output your active git branch.
  parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
  }

  # This function builds your prompt. It is called below
  function prompt {
    # Define the prompt character
    local   CHAR="☆"
    local   CHAR2="♛"

    # Define some local colors
    local   RED="\[\e[0;31m\]"
    local   BLUE="\[\e[0;34m\]"
    local   GREEN="\[\e[0;32m\]"
    local   GRAY_TEXT_BLUE_BACKGROUND="\[\e[37;44;1m\]"

    # Define a variable to reset the text color
    local   RESET="\[\e[0m\]"

    # ♥ //  ♔ ☆ - Keeping some cool ASCII Characters for reference

    # Here is where we actually export the PS1 Variable which stores the text for your prompt
    export PS1="\n\\[\e]2;\u@\h\a[$RED\t$RESET]$RED\$(parse_git_branch) $GREEN\W $BLUE//$RED $CHAR $BLUE ⇶ $RED $CHAR2 $RESET ⇰ "
      PS2='continue->'
      PS4='+ '
    }

  # Finally call the function and our prompt is all pretty
  prompt

  # For more prompt coolness, check out Halloween Bash:
  # http://xta.github.io/HalloweenBash/

  # If you break your prompt, just delete the last thing you did.
  # And that's why it's good to keep your dotfiles in git too.
  # A handy function to open your bash profile from any directory
function bp {
    $EDITOR ~/.bashrc
  }
# Environment Variables
# =====================
  # Library Paths
  # These variables tell your shell where they can find certain
  # required libraries so other programs can reliably call the variable name
  # instead of a hardcoded path.

    # NODE_PATH
    # Node Path from Homebrew I believe
    export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"

    # Those NODE & Python Paths won't break anything even if you
    # don't have NODE or Python installed. Eventually you will and
    # then you don't have to update your bash_profile

  # Configurations

    # GIT_MERGE_AUTO_EDIT
    # This variable configures git to not require a message when you merge.
    export GIT_MERGE_AUTOEDIT='no'

    # Editors
    # Tells your shell that when a program requires various editors, use sublime.
    # The -w flag tells your shell to wait until sublime exits
    export VISUAL="code-insiders"
    export SVN_EDITOR="code-insiders"
    export GIT_EDITOR="code-insiders"
    export EDITOR="code-insiders"

    # Version
    # What version of this bash profile this is
    export BASH_PROFILE_VERSION='1.5.1'
  # Paths

    # The USR_PATHS variable will just store all relevant /usr paths for easier usage
    # Each path is seperate via a : and we always use absolute paths.

    # A bit about the /usr directory
    # The /usr directory is a convention from linux that creates a common place to put
    # files and executables that the entire system needs access too. It tries to be user
    # independent, so whichever user is logged in should have permissions to the /usr directory.
    # We call that /usr/local. Within /usr/local, there is a bin directory for actually
    # storing the binaries (programs) that our system would want.
    # Also, Homebrew adopts this convetion so things installed via Homebrew
    # get symlinked into /usr/local
    export USR_PATHS="/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin"

    # Hint: You can interpolate a variable into a string by using the $VARIABLE notation as below.

    # We build our final PATH by combining the variables defined above
    # along with any previous values in the PATH variable.

    # Our PATH variable is special and very important. Whenever we type a command into our shell,
    # it will try to find that command within a directory that is defined in our PATH.
    # Read http://blog.seldomatt.com/blog/2012/10/08/bash-and-the-one-true-path/ for more on that.
    export PATH="$USR_PATHS:$PATH"

    # If you go into your shell and type: echo $PATH you will see the output of your current path.
    # For example, mine is:
    # /Users/avi/.rvm/gems/ruby-1.9.3-p392/bin:/Users/avi/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/avi/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/avi/.rvm/bin:/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/local/mysql/bin:/usr/local/share/python:/bin:/usr/sbin:/sbin:

# Helpful Functions
# =====================

# A function to CD into the desktop from anywhere
# so you just type desktop.
# HINT: It uses the built in USER variable to know your OS X username

# USE: desktop
#      desktop subfolder
function desktop {
  cd /Users/$USER/Desktop/$@
}

function exists {
  [[ -f $1 ]]
}

# Function to install tools necessary for running files at start of each lab.

function tools {
  if exists Gemfile; then
    bundle;
  fi
  if exists package.json; then
    yarn install;
  fi
}

# A Function to run tests picking between, rpsec/learn/npm depending on
# the tests to run.
function tests {
  if exists .rspec; then
    learn
  elif exists .learn; then
    rspec;
  elif exists package.json; then
    npm test;
  fi
}

# A Function to Clone & CD into the clone down git repo.

function gitgot {
  printf "\n//  cloning repo...\n\n"
  reponame=${1##*/}
  reponame=${reponame%.git}
  git clone "$1" "$reponame"
  cd "$reponame";
  printf "\n//  building dependencies...\n\n"
  tools;
  printf "\n//  opening atom-beta directory...\n"
  atom-beta .;
  printf "\n//  running tests: "
  tests;
  cd ..;
}

# A Function to submit Learn.co lessons and push up to git, then exit the document folder.

function gotgit {
  learn submit;
  cd ..
}

# A function to easily grep for a matching process
# USE: psg postgres
function psg {
  FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
  REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
  ps aux | grep "[$FIRST]$REST"
}

# cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
cdf () {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.
#    Example: mans mplayer codec
#   --------------------------------------------------------------------
mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }


    #   ---------------------------
    #   SEARCHING
    #   ---------------------------

  alias fhere="find . -name "                 # fhere:    Quickly search for file in current directory
  ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
  ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
  ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

  alias histg="history | grep"

    #   spotlight: Search for a file using MacOS Spotlight's metadata
    #   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }

    #   ---------------------------
    #   PROCESS MANAGEMENT
    #   ---------------------------

    #   findPid: find out the pid of a specified process
    #   -----------------------------------------------------
    #       Note that the command name can be specified via a regex
    #       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
    #       Without the 'sudo' it will only find processes of the current user
    #   -----------------------------------------------------
        findPid () { lsof -t -c "$@" ; }

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

    #   my_ps: List processes owned by my user:
    #   ------------------------------------------------------------
        my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

    #  psg: fuzzy search for particular process by name: psg "process name"
    #   ------------------------------------------------------------
        alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

    # NETWORKING
    #   ------------------------------------------------------------
        alias myip="curl http://ipecho.net/plain; echo"

# A function to extract correctly any archive based on extension
# USE: extract imazip.zip
#      extract imatar.tar
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)  tar xjf $1      ;;
            *.tar.gz)   tar xzf $1      ;;
            *.bz2)      bunzip2 $1      ;;
            *.rar)      rar x $1        ;;
            *.gz)       gunzip $1       ;;
            *.tar)      tar xf $1       ;;
            *.tbz2)     tar xjf $1      ;;
            *.tgz)      tar xzf $1      ;;
            *.zip)      unzip $1        ;;
            *.Z)        uncompress $1   ;;
            *)          echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

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
  alias c="clear"                             # c:            Clear terminal display
  alias ..="cd .."                            # Go back 1 directory level
  alias ...='cd ../../'                       # Go back 2 directory levels
  alias .3='cd ../../../'                     # Go back 3 directory levels
  alias .4='cd ../../../../'                  # Go back 4 directory levels
  alias .5='cd ../../../../../'               # Go back 5 directory levels
  alias .6='cd ../../../../../../'            # Go back 6 directory levels
  alias ~="cd ~"                              # ~:            Go Home

  #Make Basher better
  alias which='type -all'                     # which:        Find executables
  alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
  alias show_options='shopt'                  # Show_options: display bash options settings
  alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
  alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
  mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
  trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
  ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
  alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
  alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir

  often () {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
  }

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


  #Pairs for classes: Currently 060517
  # eval $(/usr/libexec/path_helper -s)
  # alias get_pairs='python3 /Users/flatironschool/Development/pseudo_smart_random_pairing/smart_assign.py'

  # RSPEC
  alias tspec="rspec --f-f"
  alias hspec="rspec -f h > spec_failed_tests.html; open spec_failed_tests.html"

  #alert
  # alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# Case-Insensitive Auto Completion
  bind "set completion-ignore-case on"


function ramsay () {
  eval $(ssh-agent -s) && ssh-add ~/.ssh/ramsey
  trap 'ssh-agent -k; exit' 0
}

# function startRamsayAgent () {
#   ps -u $(whoami) | grep ssh-agent &> /dev/null
# if [ $? -ne 0 ];then
#     eval $(ssh-agent -s)
#     ssh-add ~/.ssh/ramsey
#     echo "export SSH_AGENT_PID=$SSH_AGENT_PID" > ~/.agent-profile
#     echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >> ~/.agent-profile
# else
#     source ~/.agent-profile
# fi
# trap 'ssh-agent -k; exit' 0
# }

# Tiny Care Terminal settings
export TTC_BOTS='tinycarebot,selfcare_bot,magicrealismbot'
export TTC_REPOS='~/Development/code,~/Development/side_projects'
export TTC_WEATHER='New York'
export TTC_CELSIUS=false
export TTC_APIKEYS=false
export TTC_UPDATE_INTERVAL=60

# Postgres
export PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

# Final Configurations and Plugins
# =====================
  # Git Bash Completion
  # Will activate bash git completion if installed
  # via homebrew
  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
  fi

  # RVM
  # Mandatory loading of RVM into the shell
  # This must be the last line of your bash_profile always
  # source ~/.profile

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # [[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
