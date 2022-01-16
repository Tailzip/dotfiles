# zprezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# disable auto-correct
unsetopt correct

# brew zsh completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

# load custom zsh completions
FPATH=$HOME/.zsh/completions:$FPATH

# load custom zsh functions
for function in ~/.zsh/functions/*.zsh; do
  source $function
done

# enable completion
autoload -Uz compinit
compinit

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# exa
alias l="exa"
alias la="exa -a"
alias ll="exa -lah"
alias ls="exa --color=auto"

# bat
alias cat="bat"

# mcfly
eval "$(mcfly init zsh)"

# dog
alias dig="dog"

# thefuck
eval "$(thefuck --alias)"

# lima
alias docker-start="limactl start"
alias docker-stop="limactl stop"

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs

mkenv(){
  virtualenv -p $(asdf where python "$1")/bin/python "$WORKON_HOME"/"$2"
}

workon(){
  source "$WORKON_HOME"/"$1"/bin/activate
  # [ -d "$PROJECT_HOME"/"$1" ] && cd "$PROJECT_HOME"/"$1"
}
