#!/bin/bash

set -e

remoteHost=github.com
remoteUser=("ltkhang" "nttdots" "samvid25" "AlphaDelta")
remoteDir=("dn-ids-ddos-defense" "nttdots" "samvid25" "AlphaDelta")
remoteRepos=$(ssh -l $remoteUser $remoteHost "ls $remoteDir")
localCodeDir="${HOME}/CODE/"

# if no output from the remote ssh cmd, bail out
if [ -z "$remoteRepos" ]; then
    echo "No results from remote repo listing (via SSH)"
    exit
fi

# for each repo found remotely, check if it exists locally
# assumption: name repo = repo.git, to be saved to repo (w/o .git)
# if dir exists, skip, if not, clone the remote git repo into it
for gitRepo in $remoteRepos
do
  localRepoDir=$(echo ${localCodeDir}${gitRepo}|cut -d'.' -f1)
  if [ -d $localRepoDir ]; then 	
		echo -e "Directory $localRepoDir already exits, skipping ...\n"
	else
		for i in ${!remoteUser[@]}; do
			cloneCmd="git clone ssh://$remoteUser[i]@$remoteHost/$remoteDir[i]"
			cloneCmd=$cloneCmd"$gitRepo $localRepoDir"
			
			cloneCmdRun=$($cloneCmd 2>&1)

			echo -e "Running: \n$ $cloneCmd"
			echo -e "${cloneCmdRun}\n\n"
		}
	fi
done