# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My ZSH settings
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh

# Path updates
export PATH=/opt/homebrew/bin:$PATH
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# Includes
[[ ! -f ~/.zsh/aliases.zsh ]] || source ~/.zsh/aliases.zsh
[[ ! -f ~/.zsh/private.zsh ]] || source ~/.zsh/private.zsh
[[ ! -f ~/.zsh/p10k.zsh ]] || source ~/.zsh/p10k.zsh
