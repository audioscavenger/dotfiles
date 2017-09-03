#!/bin/zsh
# {{{1 enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	# ls
	alias ls='ls --color=auto'
	alias cls='ls --color=always'
	# dir
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias cdir='dir --color=always'
	alias cvdir='vdir --color=always'
	# grep
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
	alias cgrep='grep --color=always'
	alias cfgrep='fgrep --color=always'
	alias cegrep='egrep --color=always'
	# diff
	alias diff='diff --color=auto'
	alias cdiff='diff --color=always'
	# always colored pacman and yay
	alias cpacman='pacman --color=always'
	alias cyay='yay --color=always'
	# always colored ack
	alias cack='ack --color=always'
fi

# {{{1 Other aliases
# taskwarrior
alias tw=task
# YouTube-viewer perl application.
alias ytv='youtube-viewer'
# Show my YouTube Playlists with $YOUTUBE_CHANNEL_ID env var.
alias my-ytv='youtube-viewer -cp "$YOUTUBE_CHANNEL_ID"'
# xdg-open
alias o='xdg-open'
# ranger with cd into last directory
alias cranger='ranger --choosedir=/tmp/doron.rangerdir; cd `cat /tmp/doron.rangerdir`'
alias ranger='ranger --choosedir=/tmp/doron.rangerdir'
alias cdr='cd "$(cat /tmp/doron.rangerdir)"'
# extract urls from a file or stdin
alias urls="perl -ne 's#.*(https*://[^\"]*).*#\1# && print'"
# xclip
alias cxclip="xclip -selection clipboard"
alias pxclip="xclip -selection primary"
# colored cat: src-highlite
alias ccat='source-highlight --failsafe --infer-lang --out-format=esc --style-file=esc.style -i'
# systemctl poweroff/reboot
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'

# vim:ft=zsh:foldmethod=marker
