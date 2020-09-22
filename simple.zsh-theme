### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg

  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"

  echo -n "%{$bg%}%{$fg%}"

  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  echo -n "%{%k%}"
  echo -n "%{%f%}"
}

### Prompt components
# Context: user (who am I)
prompt_context() {
  local user=`whoami`

  prompt_segment default blue "%n@%m:"
}

prompt_time() {
    local curtime=`date +%H:%M:%S`

    prompt_segment default default "[$curtime"
    #[[ ! -z $ZSH_COMMAND_TIME ]] && prompt_segment default default " $ZSH_COMMAND_TIME""s"
    prompt_segment default default "] "
}

# Git: branch/detached head, dirty status
prompt_git() {
    local gitinfo=`git_prompt_info`

    prompt_segment default green "$gitinfo"
}

# Dir: current working directory
prompt_dir() {
  prompt_segment default 245 '%~ '
}

# Status:
# - was there an error
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}$RETVAL"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{white}%}*"

  [[ -n "$symbols" ]] && prompt_segment default default "$symbols "
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_time
# prompt_context
  prompt_dir
# prompt_git
  prompt_end
}

PROMPT='
$(build_prompt)
$VIMODE > '
