# Environment Variables
# =====================

# Editors
# Tells your shell that when a program requires various editors,
export VISUAL="code-insiders"
export SVN_EDITOR="code-insiders"
export GIT_EDITOR="code-insiders"
export EDITOR="code-insiders"

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

# GIT_MERGE_AUTO_EDIT
# This variable configures git to not require a message when you merge.
export GIT_MERGE_AUTOEDIT='no'

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
#!/bin/bash
# /Users/avi/.rvm/gems/ruby-1.9.3-p392/bin:/Users/avi/.rvm/gems/ruby-1.9.3-p392@global/bin:/Users/avi/.rvm/rubies/ruby-1.9.3-p392/bin:/Users/avi/.rvm/bin:/usr/local:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/local/mysql/bin:/usr/local/share/python:/bin:/usr/sbin:/sbin:


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