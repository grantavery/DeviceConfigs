# zsh config
# You'll need to change things to make it work on PC

# (Use Oh My Zsh for theme UIs, plugins, and other customizations)

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH="C:/.oh-my-zsh"
export ZSH="/Users/grantavery/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="robbyrussell"
# See ~/.oh-my-zsh/custom/grantavery.zsh for my custom UI theme
ZSH_THEME="grantavery"

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

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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
	git
	history
	brew
	npm
	nvm
	xcode
	macos
	ng
	gatsby
	copydir
	#zsh-completions (do I need this?)
)

source $ZSH/oh-my-zsh.sh

# zsh-completions config:
autoload -U compinit && compinit

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# see ~/.oh-my-zsh/lib for the files that define a bunch of aliases and functions
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# z
#. `brew --prefix`/etc/profile.d/z.sh

# Auto-open to my main directory (see below for reference)
cd $proj_dir


# zsh parameter completion for the dotnet CLI:

_dotnet_zsh_complete() 
{
  local completions=("$(dotnet complete "$words")")

  reply=( "${(ps:\n:)completions}" )
}

compctl -K _dotnet_zsh_complete dotnet




# ----------------------------------------------------------------------------
# Run a single snippet "cpd" to cd to your project directory and then tab autocomplete from there to reach your desired repo or folder (partially working)
# ----------------------------------------------------------------------------
#alias cdp="cd ~/code"
# The "complete" command doesn't work with zsh, so I can't do "cdp {tab-completion path}"
alias cdp=goToProjectDirectory

#PC: 
#proj_dir=C:/code

#Mac:
proj_dir=~/code

function goToProjectDirectory(){
	cd $proj_dir/$1
}

# The old Bash way (replaced by zsh-completions?):
# function _autocomplete(){
# 	local cur=$2
# 	local _cur compreply

# 	_cur=$proj_dir/$cur
# 	compreply=( $( compgen -d "$_cur" ) )
# 	COMPREPLY=( ${compreply[@]#$proj_dir/} )
# 	if [[ ${#COMPREPLY[@]} -eq 1 ]]; then
# 		COMPREPLY[0]=${COMPREPLY[0]}/
# 	fi
# }

#complete -F _autocomplete -o nospace cdp

# ----------------------------------------------------------------------------
# Git aliases
# ----------------------------------------------------------------------------
alias cl="git clone"
alias ch="git checkout"
alias st="git status"
alias ft="git fetch --all"
alias br="git branch"
alias cm="git commit -am" # still need to add a message after "am". (-a does all files, -m does a message; do -am for both)
alias push="git push"
alias pull="git pull"
alias stash="git stash" # still need to add a message after "stash"
alias stashp="git stash pop"
alias rb='git rebase'


# ----------------------------------------------------------------------------
# Etc. useful aliases
# ----------------------------------------------------------------------------

alias d="docker"
alias k="kubectl"

# Get your current public IP (blocked on SH network)
alias ip="curl icanhazip.com"

# Copy the working directory path:
alias cpwd="pwd|tr -d '\n' | clip"

# Clear window:
alias c="clear"

alias python="python3"

# Copy the working directory path:
# Mac:
alias cpwd="pwd|tr -d '\n' | clip"

# PC:
alias cpwd="pwd|tr -d '\n' | pbcopy"


# Mac only:

# top
alias cpu="top -o cpu"
alias mem="top -o rsize" # memory

# mute the system volume
alias mute="osascript -e 'set volume output muted true'"

# append ` | jsonpp` to any command that returns json data to have it pretty-printed. From Marco Arment
alias jsonpp='json_pp -json_opt pretty,utf8'

# Mac specific?
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
