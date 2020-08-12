#up-line-or-historyup-line-or-history If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
PATH="$PATH:$(ruby -e 'puts Gem.user_dir')/bin"
source $(dirname $(gem which colorls))/tab_complete.sh
KEYTIMEOUT=1

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting zsh-vim-mode)

#SPACESHIP
SPACESHIP_PROMPT_ADD_NEWLINE="true"
SPACESHIP_CHAR_SYMBOL=" \uf0e7"
SPACESHIP_CHAR_PREFIX=" \uf296"
SPACESHIP_CHAR_SUFFIX=(" ")
SPACESHIP_CHAR_COLOR_SUCCESS="yellow"
SPACESHIP_PROMPT_DEFAULT_PREFIX="$USER"
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_USER_SHOW="true"

bindkey -r "^K"
bindkey -r "^J"

alias ls=colorls — tree — light
alias lc=colorls — tree — light
alias v="nvim"
alias zshr="source ~/.zshrc"
alias n="node"
alias cl="clear"
alias weather="curl wttr.in/"
alias noe="echo wttr.in/ $1"
alias r="ranger"
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

source $ZSH/oh-my-zsh.sh
neofetch

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
