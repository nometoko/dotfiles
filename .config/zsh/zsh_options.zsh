setopt hist_reduce_blanks     # ignore blank
setopt hist_ignore_all_dups   # don't save the same history to .zsh_history
setopt hist_ignore_space
setopt share_history
setopt numeric_glob_sort      # sort by number when numbers are included in file-names
setopt CHASE_LINKS            # when you move to symbolic link, you will be move to the place it links
setopt ignoreeof
setopt correct
setopt PROMPT_SUBST           # for Direnv
setopt autoresume
setopt noclobber
setopt pushd_ignore_dups
setopt globdots
setopt interactive_comments
unsetopt beep
