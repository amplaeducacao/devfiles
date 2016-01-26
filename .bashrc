# .bashrc
# Origin Source: https://github.com/amplaeducacao/devfiles


#/*------------------------------------*\
	#USER VARS
#\*------------------------------------*/

URL='https://<USER>@bitbucket.org/dev-iob/'
PROJECTSPATH='C:\wamp\www\' 
HOSTSFILE='C:\Windows\System32\drivers\etc\hosts'


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

if [ -f ~/.git-flow.bash ]; then
	. ~/.git-flow.bash
fi


#/*------------------------------------*\
	#GIT BOOKMARKS
#\*------------------------------------*/

. ~/.bashmarks.sh


#/*------------------------------------*\
	#GIT CLONE
#\*------------------------------------*/

function gcl(){
	git clone $URL$1
}

#/*------------------------------------*\
	#GIT REMOTE
#\*------------------------------------*/

alias gr='git remote'
alias gra='git remote add'
alias grr='git remote remove'


#/*------------------------------------*\
	#GIT FETCH and UPDATE
#\*------------------------------------*/

alias gf='git fetch'
alias gfo='git fetch origin'
alias gru='git remote update --prune'


#/*------------------------------------*\
	#GIT STATUS
#\*------------------------------------*/

alias gs='git status'


#/*------------------------------------*\
	#GIT ADD and REMOVE
#\*------------------------------------*/

alias ga='git add -A'
alias gaf='git add '

alias gof='git checkout --'


#/*------------------------------------*\
	#GIT BRANCH
#\*------------------------------------*/

# List local branches
alias gbl='git branch'

# List remote branches
alias gbr='git branch -r'

# List all branches
alias gb='git branch -a'

# Delete local branch
alias gbdl='git branch -D'

# Delete remote branch
function gbdr(){
	git push origin :$1
}

# Delete local and remote branch
function gbd(){
	git branch -D $1
	$(gbdr $1)
}

# Go to branch
alias go='git checkout'

# Create new branch and then checked out
alias gob='git checkout -b'


#/*------------------------------------*\
	#GIT COMMIT
#\*------------------------------------*/

alias gc='git commit'
alias gca='git commit --amend'


#/*------------------------------------*\
	#GIT ADD and COMMIT
#\*------------------------------------*/

alias gac='git add -A && git commit'


#/*------------------------------------*\
	#GIT PULL and PUSH
#\*------------------------------------*/

alias gpl='git pull origin'

alias gps='git push origin'

# Push all tags
alias gpst='git push --tags'


#/*------------------------------------*\
	#GIT MERGE
#\*------------------------------------*/

alias gm='git merge --no-ff'
alias gmt='git mergetool -y'


#/*------------------------------------*\
	#GIT REBASE
#\*------------------------------------*/

alias gri='GIT_EDITOR=subl git rebase -i'


#/*------------------------------------*\
	#GIT DIFF
#\*------------------------------------*/

alias gd='git diff'
alias gdt='git difftool'
alias gds='git diff --stat'

#List all the files in a commit
alias gcf='git diff-tree --no-commit-id --name-only -r'


#/*------------------------------------*\
	#GIT OPEN MODIFIED FILES
#\*------------------------------------*/

alias gomf='git diff --name-only | xargs subl'


#/*------------------------------------*\
	#GIT UPDATE INDEX
#\*------------------------------------*/

alias gau='git update-index --assume-unchanged'
alias gnau='git update-index --no-assume-unchanged'
alias glu='git ls-files -v | grep "^h"'


#/*------------------------------------*\
	#GIT TAG
#\*------------------------------------*/

alias gt='git tag -a'
alias gtd='git tag -d'

function gtdr(){
	git push origin :refs/tags/$1
}


#/*------------------------------------*\
	#GIT STASH
#\*------------------------------------*/

alias gss='git stash save -u'
alias gsf='git stash -p'
alias gsl='git stash list'
alias gsa='git stash apply'
alias gsp='git stash pop'
alias gsc='git stash clear'

# Apply specific stash
function gsas(){
	git stash apply stash@{$1}
}
# Remove specific stash
function gsd(){
	git stash drop stash@{$1}
}
# Apply specific stash and remove it
function gsps(){
	git stash apply stash@{$1} && git stash drop stash@{$1}
}


#/*------------------------------------*\
	#GIT CLEAN CACHE
#\*------------------------------------*/

# Clean folders and files cache
alias gcc='git clean -f -d'


#/*------------------------------------*\
	#GIT ARCHIVE
#\*------------------------------------*/

# Create deploy folder
function deploy(){
	if [ ! -d deploy-temp ]; then
		mkdir deploy-temp
	fi
	if [ $1 ] ; then
		DIFF=$(git diff --name-only $1)
	fi
	git archive HEAD $DIFF | tar -x -C deploy-temp/
}


#/*------------------------------------*\
	#GIT PATCH
#\*------------------------------------*/

# Create .patch file in .git-patches folder from a commit
function gf-p(){
	if [ ! -d .git-patches ]; then
		mkdir .git-patches
	fi
	git format-patch -1 $2 --stdout > .git-patches/$1-$2.patch
}

# Apply patch
function gam(){
	git am -s -3 .git-patches/$1.patch
}

# Abort Apply Patch
alias gama='git am --abort'

# Continue after solving conflits to commit applied patch
alias gamr='git am -r'


#/*------------------------------------*\
	#GIT RESET
#\*------------------------------------*/

function grh(){
	git reset --hard HEAD^$1
}

# Reset modified file
alias grf='git reset HEAD'


#/*------------------------------------*\
	#GIT FLOW
#\*------------------------------------*/

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

alias gl='git log'
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

# Export log to JSON file
function json(){
	CURRENT=$(date +'%d-%m-%Y')
	git log  --date=local \
	    --pretty=format:'{%n  "commit": "%H",%n  "author": "%an <%ae>",%n  "date": "%ad",%n  "message": "%s"%n},' \
	    $@ | \
	    perl -pe 'BEGIN{print "["}; END{print "]\n"}' | \
	    perl -pe 's/},]/}]/' > "log-${CURRENT}.json"
}


#/*------------------------------------*\
	#UTILS
#\*------------------------------------*/

# Add/Remove .emptydir
function emptydir(){
	if [ $1 ] ; then
		ARGS=$1
	else
		ARGS='-v'
	fi
	 ../MarkEmptyDirs.exe $ARGS ./
}


# Return IPv4 number
function ip(){
	IP=`ipconfig | findstr -R -c:"IPv4" | tail -1 | sed 's/.*[^0-9.]//g'`
	echo $IP
}

# Add virtual host in Windows Hosts
function add-host(){
	if [ $2 ] ; then
		IP=$2
	else
		IP=$(ip)
	fi

	if ! grep -q "$1.local" $HOSTSFILE; then
		printf "\r\n$IP\t\t$1.local" >> $HOSTSFILE
	fi
}
# list bookmarks with dirnam
function list-host {
    cat $HOSTSFILE | awk /$(ip)/
        
    # if color output is not working for you, comment out the line below '\033[1;32m' == "red"
    # env | sort | awk '/^$IP\t.+/{split(substr($0,14),parts,"\t"); printf("\033[0;33m%-20s\033[0m %s\n", parts[1], parts[2]);}'
}

# Delete virtual host in Windows Hosts
function del-host(){
	sed -i "/$1.local/d" $HOSTSFILE
}

# Add APP Pool in IIS
function add-pool(){
	appcmd add apppool -name:"$1"
}

# Set APP Pool name in Site
function set-pool(){
	if [ $2 ] ; then
		POOL=$2
	else
		POOL=$1
	fi
	appcmd set site -site.name:"$1" -applicationDefaults.applicationPool:"$POOL"
}

# Delete APP Pool in IIS
function del-pool(){
	appcmd delete apppool "$1"
}

# Start APP Pool
function start-pool(){
	appcmd start apppool $1
}

# Stop APP Pool
function stop-pool(){
	appcmd stop apppool $1
}

# Add Site, APP Pool and host name
function add-site(){
	IP=$(ip); 
	PORT=80;
	if [ $2 ] ; then
		FOLDER=$2
	else
		FOLDER=$1
	fi
	add-pool $1
	appcmd add site -name:"$1" -bindings:http/$IP:$PORT:$1.local -physicalPath:$PROJECTSPATH$FOLDER
	set-pool $1
	appcmd set config "$1" -section:asp -enableParentPaths:"true" /commit:apphost
	add-host $1
}

# Delete Site, APP Pool and host name
function del-site(){
	appcmd delete site "$1"
	del-pool $1
	del-host $1
}

# Start Site
function start-site(){
	appcmd start site $1
}

# Stop Site
function stop-site(){
	appcmd stop site $1
}

# Start IIS and stop wamp
function start-iis(){
	net stop postgresql-x64-9.3
	net stop wampapache64
	net start w3svc
}

# Start/Stop wamp
function wamp(){
	if [ "$1" == "start" ] ; then
		iis stop
	fi
	net $1 wampapache64
}

# Start/Stop IIS
function iis(){
	if [ "$1" == "start" ]; then
		wamp stop
	fi
	net $1 w3svc
}

# Start/Stop postgres
function postgres(){
	net $1 postgresql-x64-9.3
}

# Start mongo
function mongo(){
	start ~/start-mongo.bat
}

# Create environment variables in Windows
function set-var(){
	setx "$1" "$2" -m
}

#/*------------------------------------*\
	#GIT COMPLETE
#\*------------------------------------*/

__git_complete gf _git_fetch
__git_complete grr _git_fetch

__git_complete gf-p _git_fetch
__git_complete gam _git_fetch

__git_complete gbl _git_branch
__git_complete gbdl _git_branch
__git_complete gbdr _git_branch
__git_complete gbd _git_branch

__git_complete go _git_checkout
__git_complete gob _git_checkout

__git_complete gpl _git_branch
__git_complete gps _git_branch

__git_complete gm _git_branch

__git_complete gfi __git_flow_init

__git_complete gfs __git_flow_feature_start
__git_complete gff __git_flow_feature_finish
__git_complete gfp __git_flow_feature_pull
__git_complete gfps __git_flow_feature_publish
__git_complete gft __git_flow_feature_track

__git_complete gfrs __git_flow_release_start
__git_complete gfrf __git_flow_release_finish
__git_complete gfrp __git_flow_release_pull
__git_complete gfrps __git_flow_release_publish
__git_complete gfrt __git_flow_release_track

__git_complete gfhs __git_flow_hotfix_start
__git_complete gfhf __git_flow_hotfix_finish
