# zprezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# disable auto-correct
unsetopt correct

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"

  if which pyenv-virtualenv-init > /dev/null; then 
    eval "$(pyenv virtualenv-init -)"
  fi
fi

# nodenv
if command -v nodenv 1>/dev/null 2>&1; then
  eval "$(nodenv init -)"
fi
