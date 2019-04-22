#!/bin/zsh

# {{{1 `_command_exists`: Show if a command exists
# Taken from http://stackoverflow.com/a/592649/4935114
_command_exists () {
	type "$1" &> /dev/null ;
}
# {{{1 `insert2PATH`: function to insert (in the beginning) of $PATH a directory only if it doesn't exist already.
insert2PATH(){
	# For all strings passed to function
	for i in "$@"; do
		# If the directory exists and it doesn't exists already in $PATH
		if [[ -d "$i" ]] && ! echo $PATH | grep -q "$i"; then
			export PATH="$i"":""$PATH"
		fi
	done
}
# {{{1 `insert2MANPATH`: function to insert (in the beginning) of $MANPATH a directory only if it doesn't exist already.
insert2MANPATH(){
	# For all strings passed to function
	for i in "$@"; do
		# If the directory exists
		if [ -d "$i" ]; then
			# If it doesn't exists already in $MANPATH
			if ! echo $MANPATH | grep -q "$i"; then
				export MANPATH="$i"":""$MANPATH"
			fi
		else
			echo \'error at: .zshenv\': you have tried to insert "$i" to MANPATH but it\'s not a directory or it doesn\'t exist
		fi
	done
}
# }}}1
# {{{1 DOMAIN and FQDN
export DOMAIN="$(hostname -d)"
export FQDN="$(hostname -f)"
if [[ "$FQDN" == "$HOST" ]]; then
	FQDN='same_as_host'
fi

# - {{{1 PATH
insert2PATH "$HOME/.local/bin"
insert2PATH "$HOME/.bin"
insert2PATH "$HOME/.go/bin"
insert2PATH "$HOME/.luarocks/bin"
insert2PATH "$HOME/.gem/ruby/2.4.0/bin/"
insert2PATH "$HOME/.yarn/bin"
insert2PATH "$HOME/.config/yarn/global/node_modules/.bin"
if _command_exists ccache; then
	insert2PATH "/usr/lib/ccache/bin"
fi
# - {{{1 Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
insert2PATH "$HOME/.rvm/bin"

# - {{{1 CPAN
insert2PATH "$HOME/.perl5/bin"
if _command_exists perl; then
	export PERL5LIB="${HOME}/.perl5/lib/perl5"
	export PERL_LOCAL_LIB_ROOT="${HOME}/.perl5/local/perl5/lib/perl5"
	export PERL_MB_OPT="--install_base ${HOME}/.perl5"
	export PERL_MM_OPT="INSTALL_BASE=${HOME}/.perl5"
fi

# - {{{1 LUA_PATH and LUA_CPATH
if _command_exists luarocks; then
	eval $(luarocks path)
fi

# - {{{1 VISUAL/EDITOR
if _command_exists nvim; then
	if [[ -z $NVIM_LISTEN_ADDRESS ]]; then
		export EDITOR="nvim"
		export VISUAL="nvim"
		export MANPAGER="$EDITOR --cmd 'let g:loaded_youcompleteme = 1' --cmd 'let g:did_coc_loaded = 1' -c 'set ft=man' -"
		export MANWIDTH=999
	else
		export EDITOR="nvr --remote-silent --remote-wait"
		export VISUAL="nvr --remote-silent --remote-wait"
		export MANPAGER="$EDITOR -c 'set ft=man' -"
	fi
	export SUDO_EDITOR="env XDG_CONFIG_HOME=${HOME}/.config $EDITOR"
elif _command_exists vim; then
	export EDITOR="vim"
	export VISUAL="vim"
	export SUDO_EDITOR="env VIM=${HOME}/.vim vim"
	export MAN_PN=1 
	export MANPAGER="$EDITOR --remote-silent --remote-wait 'let g:loaded_youcompleteme = 1' --cmd 'let g:did_coc_loaded = 1' -M +MANPAGER -"
else
	# taken from wiki.archlinux.org
	export MANPAGER=env\ LESS_TERMCAP_mb=$'\E[01;31m'\ LESS_TERMCAP_md=$'\E[01;38;5;74m'\ LESS_TERMCAP_me=$'\E[0m'\ LESS_TERMCAP_se=$'\E[0m'\ LESS_TERMCAP_so=$'\E[38;5;246m'\ LESS_TERMCAP_ue=$'\E[0m'\ LESS_TERMCAP_us=$'\E[04;38;5;146m'\ less
fi
export GIT_EDITOR="$VISUAL"

# - {{{1 gcc
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# - {{{1 git
export EMPTY_COMMIT_HASH=4b825dc642cb6eb9a060e54bf8d69288fbee4904

# - {{{1 xdg
if [[ -f "$HOME/.config/user-dirs.dirs" ]]; then
	source "$HOME/.config/user-dirs.dirs"
fi

# - {{{1 COLUMNS
export COLUMNS=

# - {{{1 local environmental variables
if [[ -f "$HOME/.local/share/zsh/env/${TERM}" ]]; then
	source "$HOME/.local/share/zsh/env/${TERM}"
fi
if [[ -f "$HOME/.local/share/zsh/env/${DISPLAY}" ]]; then
	source "$HOME/.local/share/zsh/env/${DISPLAY}"
fi
if [[ -f "$HOME/.local/share/zsh/env/${VENDOR}" ]]; then
	source "$HOME/.local/share/zsh/env/${VENDOR}"
fi
if [[ -f "$HOME/.local/share/zsh/env/${OSTYPE}" ]]; then
	source "$HOME/.local/share/zsh/env/${OSTYPE}"
fi
if [[ -f "$HOME/.local/share/zsh/env/${HOST}" ]]; then
	source "$HOME/.local/share/zsh/env/${HOST}"
fi
if [[ -f "$HOME/.local/share/zsh/env/${FQDN}" ]]; then
	source "$HOME/.local/share/zsh/env/${FQDN}"
fi
if [[ -f "$HOME/.local/share/zsh/env/${DOMAIN}" ]]; then
	source "$HOME/.local/share/zsh/env/${DOMAIN}"
fi

# - {{{1
# vim:ft=zsh:foldmethod=marker
