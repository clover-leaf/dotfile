export BAT_THEME=gruvbox-dark

export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$PATH:Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"
export EDITOR=nvim

ZSH_THEME="geoffgarside"

plugins=(git)

source $ZSH/oh-my-zsh.sh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.nvm/nvm.sh

# preferred neovim as editor
alias vim='nvim'

# git
alias glg='git log'
alias gst='git status'
alias gcm='git commit -m'
alias gdf='git diff'
alias gco='git checkout'
alias gad='git add'

# tmuxinator
alias mux=tmuxinator

[[ "$TERM_PROGRAM" == "CodeEditApp_Terminal" ]] && . "/Volumes/CodeEdit/CodeEdit.app/Contents/Resources/codeedit_shell_integration.zsh"
