# The userdef command
function up
{
	i=$1;
	while [ $((i--)) -gt 0 ];
	do
		cd ../ && pwd;
		done
}

function gitdiff ()
{
	git diff $@ | colordiff | less -R;
}

# alias
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw"

# use xterm in screen
export TERM="xterm"
export CLICOLOR=1
