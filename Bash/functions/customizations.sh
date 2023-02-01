# A handy function to open your bash profile from any directory
function bp() {
    $EDITOR ~/.bashrc 
}

# Helpful Functions
# =====================

# A function to CD into the desktop from anywhere
# so you just type desktop.
# HINT: It uses the built in USER variable to know your OS X username

# USE: desktop
#      desktop subfolder
function desktop() {
    cd /Users/$USER/Desktop/$@
}

function exists() {
    [[ -f $1 ]]
}

# Function to install tools necessary for running files at start of each lab.

function tools() {
    if exists Gemfile; then
        bundle
    fi
    if exists package.json; then
        yarn install
    fi
}

# A Function to run tests picking between, rpsec/learn/npm depending on
# the tests to run.
function tests() {
    if exists .rspec; then
        learn
    elif exists .learn; then
        rspec
    elif exists package.json; then
        npm test
    fi
}

# A Function to Clone & CD into the clone down git repo.

function gitgot() {
    printf "\n//  cloning repo...\n\n"
    reponame=${1##*/}
    reponame=${reponame%.git}
    git clone "$1" "$reponame"
    cd "$reponame"
    printf "\n//  building dependencies...\n\n"
    tools
    printf "\n//  opening atom-beta directory...\n"
    $EDITOR .
    printf "\n//  running tests: "
    tests
    cd ..
}

# A Function to submit Learn.co lessons and push up to git, then exit the document folder.

function gotgit() {
    learn submit
    cd ..
}

# A function to easily grep for a matching process
# USE: psg postgres
function psg() {
    FIRST=$(echo $1 | sed -e 's/^\(.\).*/\1/')
    REST=$(echo $1 | sed -e 's/^.\(.*\)/\1/')
    ps aux | grep "[$FIRST]$REST"
}

# cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
function cdf() {
    currFolderPath=$(
        /usr/bin/osascript <<EOT
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

# A function to extract correctly any archive based on extension
# USE: extract imazip.zip
#      extract imatar.tar
function extract() {
    if [ -f $1 ]; then
        case $1 in
        *.tar.bz2) tar xjf $1 ;;
        *.tar.gz) tar xzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.rar) rar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xf $1 ;;
        *.tbz2) tar xjf $1 ;;
        *.tgz) tar xzf $1 ;;
        *.zip) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

function addAndStartThisSshFile () {
eval $(ssh-agent -s) && ssh-add ~/.ssh/"$@"
trap 'ssh-agent -k; exit' 0
}


#   ---------------------------
#   SEARCHING
#   ---------------------------

function often() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n50
}

function ff() { /usr/bin/find . -name "$@"; }     # ff:       Find file under the current directory
function ffs() { /usr/bin/find . -name "$@"'*'; } # ffs:      Find file whose name starts with a given string
function ffe() { /usr/bin/find . -name '*'"$@"; } # ffe:      Find file whose name ends with a given string

#   ---------------------------
#   PROCESS MANAGEMENT
#   ---------------------------

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command; }

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
function spotlight() { mdfind "kMDItemDisplayName == '$@'wc"; }

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
function findPid() { lsof -t -c "$@"; }

function mcd() { mkdir -p "$1" && cd "$1"; }       # mcd:          Makes new Dir and jumps inside

function trash() { command mv "$@" ~/.Trash; }     # trash:        Moves a file to the MacOS trash

function ql() { qlmanage -p "$*" >&/dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#   displays paginated result with colored search terms and two lines surrounding each hit.
#    Example: mans mplayer codec
#   --------------------------------------------------------------------
function mans() {
    man $1 | grep -iC2 --color=always $2 | less
}

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
function showa() { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc; }
