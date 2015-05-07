# .bashrc
# Origin Source: http://github.com/durdn/cfg/.bashrc


#/*------------------------------------*\
	#GIT SETTINGS
#\*------------------------------------*/

export HISTFILESIZE=999999
export HISTSIZE=999999
export HISTCONTROL=ignoredups:ignorespace
shopt -s histappend
shopt -s checkwinsize
shopt -s progcomp

#make sure the history is updated at every command
export PROMPT_COMMAND="history -a; history -n;"

#sets vi mode for shell
#set -o vi

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi


#/*------------------------------------*\
	#GIT BOOKMARKS
#\*------------------------------------*/

# Bashmarks from https://github.com/huyng/bashmarks (see copyright there) {{{
# USAGE:
# s bookmarkname - saves the curr dir as bookmarkname
# g bookmarkname - jumps to the that bookmark
# g b[TAB] - tab completion is available
# l - list all bookmarks

# setup file to store bookmarks
if [ ! -n "$SDIRS" ]; then
    SDIRS=~/.sdirs
fi
touch $SDIRS

# save current directory to bookmarks
function s {
  cat ~/.sdirs | grep -v "export DIR_$1=" > ~/.sdirs1
  mv ~/.sdirs1 ~/.sdirs
  echo "export DIR_$1=$PWD" >> ~/.sdirs
}

# jump to bookmark
function g {
  source ~/.sdirs
  cd $(eval $(echo echo $(echo \$DIR_$1)))
}

# delete bookmark
function d {
    findstr /v /r 
}

# list bookmarks with dirnam
function l {
  source ~/.sdirs
  env | grep "^DIR_" | cut -c5- | grep "^.*="
}
# list bookmarks without dirname
function _l {
  source ~/.sdirs
  env | grep "^DIR_" | cut -c5- | grep "^.*=" | cut -f1 -d "="
}

# safe delete line from sdirs
function _purge_line {
    if [ -s "$1" ]; then
        # safely create a temp file
        t=$(mktemp -t bashmarks.XXXXXX) || exit 1
        trap "rm -f -- '$t'" EXIT

        # purge line
        sed "/$2/d" "$1" > "$t"
        mv "$t" "$1"

        # cleanup temp file
        rm -f -- "$t"
        trap - EXIT
    fi
}


#/*------------------------------------*\
	#GIT STATUS
#\*------------------------------------*/

alias gs='git status '


#/*------------------------------------*\
	#GIT ADD and REMOVE
#\*------------------------------------*/

alias ga='git add -A'
alias gaf='git add '

alias gof='git checkout -- '


#/*------------------------------------*\
	#GIT BRANCH
#\*------------------------------------*/

alias gbl='git branch '
alias gbr='git branch -r'
alias gb='git branch -a'

alias gbdl='git branch -D'

function gbdr(){
	git push origin :$1
}

function gbd(){
	git branch -D $1
	git push origin :$1
}

# git rename current branch and backup if overwritten
function gbrn(){
  curr_branch_name=$(git branch | grep \* | cut -c 3-);
  if [ -z $(git branch | cut -c 3- | grep -x $1) ]; then
	git branch -m $curr_branch_name $1
  else 
	temp_branch_name=$1-old-$RANDOM;
	echo target branch name already exists, renaming to $temp_branch_name
	git branch -m $1 $temp_branch_name
	git branch -m $curr_branch_name $1
  fi
}

alias go='git checkout '

alias gob='git checkout -b '



#/*------------------------------------*\
	#GIT COMMIT
#\*------------------------------------*/

alias gc='git commit'
alias gca='git commit --amend'


#/*------------------------------------*\
	#GIT PULL and PUSH
#\*------------------------------------*/

alias gpl='git pull origin '

alias gps='git push origin '


#/*------------------------------------*\
	#GIT MERGE
#\*------------------------------------*/

alias gm='git merge --no-ff '


#/*------------------------------------*\
	#GIT DIFF
#\*------------------------------------*/

alias gd='git diff '


#/*------------------------------------*\
	#GIT TAG
#\*------------------------------------*/

alias gt='git tag -a '


#/*------------------------------------*\
	#GIT STASH
#\*------------------------------------*/

alias gss='git stash save '
alias gsf='git stash --patch'
alias gsl='git stash list '
alias gsa='git stash apply'
alias gsp='git stash pop'
alias gsc='git stash clear'

function gsas(){
	git stash apply stash@{$1}
}
function gsd(){
	git stash drop stash@{$1}
}
function gsps(){
	git stash apply stash@{$1}
	git stash drop stash@{$1}
}


#/*------------------------------------*\
	#GIT RESET
#\*------------------------------------*/

alias gr='git reset '
alias grh='git reset --hard HEAD~'
alias grhc='git reset --hard '
alias grf='git reset HEAD^ '


#/*------------------------------------*\
	#GIT UPDATE
#\*------------------------------------*/

alias gru='git remote update --prune'
alias gfo='git fetch origin'


#/*------------------------------------*\
	#GIT FLOW
#\*------------------------------------*/

alias gf='git flow'
alias gfi='git flow init'

alias gfs='git flow feature start'
alias gff='git flow feature finish'
alias gfp='git flow feature pull'
alias gfps='git flow feature publish'
alias gft='git flow feature track'

alias gfrs='git flow release start'
alias gfrf='git flow release finish'
alias gfrp='git flow release pull'
alias gfrps='git flow release publish'
alias gfrt='git flow release track'

alias gfhs='git flow hotfix start'
alias gfhf='git flow hotfix finish'


#/*------------------------------------*\
	#GIT LOG
#\*------------------------------------*/

alias gl='git log '
alias gle='git log --oneline --decorate'
alias gll='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
alias gls1='git log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'
alias glds='git log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short --graph'
alias gls='git log --pretty=format:"%C(green)%h\\ %C(yellow)[%ad]%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative'
alias glg='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias glp='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

function sprint_author(){
	CURRENT=$(date +'%d-%m-%Y')
	git log $1..HEAD  --date=local --author=$2 --pretty=format:'================================================%ncommit: %h%nAuthor: %an%nDate: %ad (%ar)%n%x09%s%n%n' > "$2-${CURRENT}.txt"
}

function json(){
	CURRENT=$(date +'%d-%m-%Y')
	git log  --date=local \
	    --pretty=format:'{%n  "commit": "%H",%n  "author": "%an <%ae>",%n  "date": "%ad",%n  "message": "%s"%n},' \
	    $@ | \
	    perl -pe 'BEGIN{print "["}; END{print "]\n"}' | \
	    perl -pe 's/},]/}]/' > "log-${CURRENT}.txt"
}

#/*------------------------------------*\
	#GIT COMPLETE
#\*------------------------------------*/

__git_complete gbl _git_branch
__git_complete gbdl _git_branch
__git_complete gbdr _git_branch
__git_complete gbd _git_branch

__git_complete go _git_checkout
__git_complete gob _git_checkout

__git_complete gpl _git_branch
__git_complete gps _git_branch

__git_complete gm _git_branch


#/*------------------------------------*\
	#UTILS
#\*------------------------------------*/

function u {
	case $1 in
		#lista todas functions
		fun|f)
			typeset -F | col 3 | grep -v _
		;;
		#lista todas definições de functions
		def|d)
			typeset -f $2
		;;

		help|h|*)
			echo "[u]tils commands available:"
			echo " [cr]eate, [li]st, [cl]one"
			echo " [i]nstall,[m]o[v]e, [re]install"
			echo " [f|fun] lists all bash functions defined in .bashrc"
			echo " [def] <fun> lists definition of function defined in .bashrc"
			echo " [k]ey <host> copies ssh key to target host"
			echo " [tr]ackall], [h]elp"
		;;
	esac
}
