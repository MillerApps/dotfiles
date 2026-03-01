# Section: Instant Prompt
# Note: Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Note: Initialization code that may require console input (password prompts, [y/n]
# Note: confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Section: Kitty Re-center
# Note: Ensure Kitty is centered on screen 
# Note: for Macos
if [[ $TERM == "xterm-kitty" ]]; then
        osascript <<EOF
  tell application "System Events"
    keystroke "c" using {control down, option down}
  end tell
EOF
 fi
# Note: End Kitty Re-center

# Section: Oh-My-Zsh
# Note: Path to your oh-my-zsh installation.
export ZSH=$OH_MY_ZSH

# Note: Uncomment the following line to display red dots whilst waiting for completion.
# Note: You can also set it to another string to have that shown instead of the default red dots.
# Note: e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Note: Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Note: Which plugins would you like to load?
# Note: Standard plugins can be found in $ZSH/plugins/
# Note: Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Note: Example format: plugins=(rails git textmate ruby lighthouse)
# Note: Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Section: Environment and Paths
# Note: Homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# Note: Sets default ediotr to NeoVim
export VISUAL=nvim; export EDITOR="$VISUAL"

# Note: Add GO/bin to PATH
export PATH="$HOME/go/bin:$PATH"

# Section: Tool Initialization
# Note: ---- FZF -----

# Note: Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Note: Advanced customization of fzf options via _fzf_comprun function
# Note: - The first argument to the function is the name of the command.
# Note: - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

eval "$(atuin init zsh)"

# Note: Zoxide
eval "$(zoxide init zsh)"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Section: Theme and Prompt
source $POWERLEVEL10K/powerlevel10k.zsh-theme

# Note: To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Section: Aliases
# Note: Set personal aliases, overriding those provided by oh-my-zsh libs,
# Note: plugins, and themes. Aliases can be placed here, though oh-my-zsh
# Note: users are encouraged to define aliases within the ZSH_CUSTOM folder.
# Note: For a full list of active aliases, run `alias`.
alias zconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
# Note: Alias for eza
alias ls='eza --color=always --icons -a'
# Note: Nvim alias
alias nv='nvim'
# Note: Lazygit alias
alias lg='lazygit'
alias cd='z'
# Note: simple workaround for editing files over ssh with nvim
alias sshedit='_f() { local f="/tmp/ssh-$(date +%s)-$(basename "$1")"; scp "$1" "$f" && nvim "$f" && scp "$f" "$1" && rm "$f"; }; _f'

# Section: Functions
# Note: Yazi
alias y='yazi'
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
# Note: End Yazi

# Note: chpwd to run ls after every directory change
chpwd() {
  ls
}

# Section: Suffix Aliases - Open Files by Extension
# Note: Just type the filename to open it with the associated program
alias -s md=glow
alias -s go='$EDITOR'
alias -s txt=bat
alias -s log=bat
alias -s py='$EDITOR'

# Section: Global Aliases - Use Anywhere in Commands
# Note: Redirect stderr to /dev/null
alias -g NE='2>/dev/null'

# Note: Redirect stdout to /dev/null
alias -g NO='>/dev/null'

# Note: Redirect both stdout and stderr to /dev/null
alias -g NUL='>/dev/null 2>&1'

# Note: Pipe to jq
alias -g J='| jq'

# Note: Copy output to clipboard (macOS)
alias -g C='| pbcopy'

# Section: Optional and Disabled
# Optional: Adds syntax highlighting to zsh
# source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Optional: Adds suggestions as you type
# source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Optional: Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Optional: History options
# setopt share_history
# setopt hist_expire_dups_first
# setopt hist_ignore_dups
# setopt hist_verify

# Optional: completion using arrow keys (based on history)
# bindkey '^[[A' history-search-backward
# bindkey '^[[B' history-search-forward
