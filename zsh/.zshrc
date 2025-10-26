export BAT_THEME=gruvbox-dark

export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$PATH:Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/.jenv/bin"
export PATH="$PATH:$HOME/.local/bin"
export EDITOR=nvim

export GITEA_SERVER_URL="http://localhost:3000"
export GITEA_API_TOKEN="REDACTED_TOKEN"
export GITEA_USERNAME="thitthan"

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

# java
alias java-11='jenv local 11.0.26;java -version'
alias java-17='jenv local 17.0.14;java -version'
alias java-21='jenv local 21.0.6n;java -version'

# aider
alias aider-deep-seek='aider --model deepseek --api-key deepseek='

# tmuxinator
alias mux=tmuxinator

export PATH="$HOME/.local/bin:$PATH"
eval "$(jenv init -)"

# pnpm
export PNPM_HOME="/Users/thangnguyen/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
