# .bashrc
# Origin Source: https://github.com/amplaeducacao/devfiles


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
	#GIT REMOTE
#\*------------------------------------*/

alias gra='git remote add'


#/*------------------------------------*\
	#GIT UPDATE
#\*------------------------------------*/

alias gru='git remote update --prune'
alias gfo='git fetch origin'


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

# List local branches
alias gbl='git branch '

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
	git push origin :$1
}

# Rename current branch and backup if overwritten
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

# Create new branch and then checked out
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

# Push all tags
alias gpst='git push --tags'


#/*------------------------------------*\
	#GIT MERGE
#\*------------------------------------*/

alias gm='git merge --no-ff '


#/*------------------------------------*\
	#GIT DIFF
#\*------------------------------------*/

alias gd='git diff '


#/*------------------------------------*\
	#GIT OPEN MODIFIED FILES
#\*------------------------------------*/

alias gomf='git diff --name-only | xargs subl'


#/*------------------------------------*\
	#GIT TAG
#\*------------------------------------*/

alias gt='git tag -a '


#/*------------------------------------*\
	#GIT STASH
#\*------------------------------------*/

alias gss='git stash save '
alias gsf='git stash -p'
alias gsl='git stash list '
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
	git stash apply stash@{$1}
	git stash drop stash@{$1}
}


#/*------------------------------------*\
	#GIT CLEAN CACHE
#\*------------------------------------*/

# Clean folders and files cache
alias gcc='git clean -f -d'


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

# Continue after solving conflits to commit applied patch
alias gamr='git am -r'


#/*------------------------------------*\
	#GIT RESET
#\*------------------------------------*/

alias gr='git reset'
alias grh='git reset --hard HEAD~'
alias grhc='git reset --hard'

# Reset modified file
alias grf='git reset HEAD^'


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

__git_complete gf _git_flow
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
