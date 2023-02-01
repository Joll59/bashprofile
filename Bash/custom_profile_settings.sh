#!/bin/bash -xv


# Exit on Error
# set -eu

#Print Command to Terminal
# set -x


parent_path=$(
    cd "$(dirname "${BASH_SOURCE[0]}")"
    pwd -P
)

## my original prompt file: tweaky but not really reliable source $parent_path/display/prompt.sh

## load in oh-my-posh (easy-term is preferred but cloud-native-azure is nice theme config too)
eval "$(oh-my-posh init bash --config ~/.poshthemes/easy-term.omp.json)"

source $parent_path/functions/customizations.sh
source $parent_path/bash_aliases.sh
source $parent_path/environment.sh
