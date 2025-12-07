# Demos Zsh Theme
# Author: stephen@demos.zone

# ==============================================================================
# CONFIGURATION
# ==============================================================================

# Internal colors and styling
local DEMOS_COLOR_SEP="%F{white}"       # Separators
local DEMOS_COLOR_HOST="%F{green}"      # Hostname
local DEMOS_COLOR_DIR="%F{cyan}"        # Directory
local DEMOS_COLOR_ERR="%F{red}%B"       # Error codes
local DEMOS_COLOR_CABAL="%F{yellow}%B"  # Cabal/Stack
local DEMOS_RESET="%f%b"

local DEMOS_CHAR_START="│"
local DEMOS_CHAR_SEP="|"
local DEMOS_CHAR_PROMPT="│>"

# ==============================================================================
# GIT PROMPT SETTINGS (Oh My Zsh)
# ==============================================================================

# ==============================================================================
# GIT PROMPT SETTINGS
# ==============================================================================

# Custom colors for the branch name depending on status
ZSH_THEME_GIT_PROMPT_PREFIX="|"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "

# ==============================================================================
# SEGMENTS
# ==============================================================================

function demos_cabal_info() {
  # Simple detection for Cabal/Stack projects
  local cabal_files=(*.cabal(N))
  if (( ${#cabal_files} > 0 )); then
    local cabal_name=${cabal_files[1]%.cabal}
    local icon="📦" # Box icon for package
    if [[ -f cabal.sandbox.config || -f stack.yaml ]]; then
      echo "${DEMOS_COLOR_SEP}${DEMOS_CHAR_SEP}${DEMOS_RESET} ${DEMOS_COLOR_CABAL}${cabal_name}${DEMOS_RESET}"
    else
      echo "${DEMOS_COLOR_SEP}${DEMOS_CHAR_SEP}${DEMOS_RESET} ${DEMOS_COLOR_ERR}${cabal_name}${DEMOS_RESET}"
    fi
  fi
}

function demos_return_code() {
  # Only show return code if it's non-zero
  echo "%(?..${DEMOS_COLOR_SEP}${DEMOS_CHAR_SEP}${DEMOS_COLOR_ERR}%?${DEMOS_RESET})"
}

# ==============================================================================
# PROMPT CONSTRUCTION
# ==============================================================================

function build_demos_prompt() {
  # Line 1:
  # │host|git_status|cabal|dir|error

  local p=""

  # Start & Host
  p+="${DEMOS_COLOR_SEP}${DEMOS_CHAR_START}${DEMOS_COLOR_HOST}%m${DEMOS_RESET}"

  # Git prompt info
  p+='$(git_super_status)'

  # Integration: Cabal
  p+='$(demos_cabal_info)'

  # Directory
  p+="${DEMOS_COLOR_SEP}${DEMOS_CHAR_SEP}${DEMOS_RESET}${DEMOS_COLOR_DIR}%~${DEMOS_RESET}"

  # Return Code
  p+='$(demos_return_code)'

  # Newline
  p+=$'\n'

  # Line 2:
  # │>
  p+="${DEMOS_COLOR_SEP}${DEMOS_CHAR_PROMPT} ${DEMOS_RESET}"

  PROMPT="$p"
  # git-prompt puts the status in the right prompt, but we put it in the main prompt manually, so
  # clear it.
  unset RPROMPT
}

build_demos_prompt
