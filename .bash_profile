# Bash Profile (this is going to get outdated because I've switched to zsh)

# ----------------------------------------------------------------------------
# Where to store them and how to use them
# ----------------------------------------------------------------------------

# If you've never used bash profiles before, you can start by just taking the contents of this file 
# and pasting it into your computer's bash profile. If for some reason one doesn't exist,
# you can easily copy this whole file over to the appropriate location and rename it.

# Mac file location:
  # {HardDrive}/Users/{YourUserName}/.bash_profile
  # (You might need need to use the keyboard shortcut {Command Shift .} to get hidden files like .bash_profile to show up)

# PC file location:
  # C:\Users\{YourUserName}\.bash_profile

# To use a bash alias, open a Git Bash terminal and type one of the text snippets between the word "alias" and the = sign
# For example, type "cl" to run the command "git clone". These can all be customized and renamed to fit your personal needs.


# ----------------------------------------------------------------------------
# UI format of the top line
# ----------------------------------------------------------------------------

parse_git_branch() 
{ 
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/';
}

# Left side:
export PS1='\[\033]0;\h:${PWD//[^[:ascii:]]/?}\007\]\h: \[\033[36m\]\w\[\033[35m\]'\$'(parse_git_branch)\[\033[00m\]'$'\n$ '

# Right side:
# export PS2=""


# ----------------------------------------------------------------------------
# Git aliases
# ----------------------------------------------------------------------------

alias cl="git clone"
alias ch="git checkout"
alias st="git status"
alias ft="git fetch"
alias br="git branch"
alias cm="git commit -am" # still need to add a message after "am". (-a does all files, -m does a message; do -am for both)
alias push="git push"
alias pull="git pull"
alias stash="git stash" # still need to add a message after "stash"
alias stashp="git stash pop"
alias ".."="cd .."
alias "..."="cd ../../"
alias "...."="cd ../../../"
alias "....."="cd ../../../../"
alias "......"="cd ../../../../../"

# ----------------------------------------------------------------------------
# Run a single snippet "cpd" to cd to your project directory and then tab autocomplete from there to reach your desired repo or folder
# ----------------------------------------------------------------------------

alias cdp=goToProjectDirectory

#PC: 
#proj_dir=C:/code

#Mac:
proj_dir=~/code

goToProjectDirectory() { cd $proj_dir/$1; }

_autocomplete() {
	local cur=$2
	local _cur compreply

	_cur=$proj_dir/$cur
	compreply=( $( compgen -d "$_cur" ) )
	COMPREPLY=( ${compreply[@]#$proj_dir/} )
	if [[ ${#COMPREPLY[@]} -eq 1 ]]
  then
		COMPREPLY[0]=${COMPREPLY[0]}/
	fi;
}

complete -F _autocomplete -o nospace cdp


# ----------------------------------------------------------------------------
# Etc. useful aliases
# ----------------------------------------------------------------------------

alias d="docker"
alias k="kubectl"

# Get your current public IP (blocked on SH network)
alias ip="curl icanhazip.com"

# Clear window:
alias c="clear"

alias python="python3"

# Copy the working directory path:
# PC:
# alias cpwd="pwd|tr -d '\n' | clip"

# Mac:
alias cpwd="pwd|tr -d '\n' | pbcopy"


# Mac only:

# top
alias cpu="top -o cpu"
alias mem="top -o rsize" # memory

# mute the system volume
alias mute="osascript -e 'set volume output muted true'"

# Echo all executable Paths
alias path='echo -e ${PATH//:/\\n}'




###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

if type complete &>/dev/null; then
  _npm_completion () {
    local words cword
    if type _get_comp_words_by_ref &>/dev/null; then
      _get_comp_words_by_ref -n = -n @ -n : -w words -i cword
    else
      cword="$COMP_CWORD"
      words=("${COMP_WORDS[@]}")
    fi

    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${words[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
    if type __ltrim_colon_completions &>/dev/null; then
      __ltrim_colon_completions "${words[cword]}"
    fi
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi;
###-end-npm-completion-###
