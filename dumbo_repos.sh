#!/bin/bash
# dumbo_repos.sh
# 
# Create new github repository from supplied argument
#
# Usage: 
#   dumbo_repo.sh <org_name> <number_of_repos>
#
# Example: 
#   dumbo_repo.sh my-org 10
#
declare MAX_FILE_LINES=$(wc -l </usr/share/dict/words)
declare ORG=$1
declare REPOS_COUNT=$2

echo -e "WARNING: Creating ${REPOS_COUNT} in ${ORG}"
# prompt user for confirmation
read -p "Are you sure? [(y)es|(n)o]" -n 1 -r
echo -e "\n"

if [[ $REPLY =~ ^[Yy]$ ]]
then
  for i in $(seq 1 $REPOS_COUNT); do
    declare REPO_NAME=$(sed -n "$(( 1 + RANDOM % $MAX_FILE_LINES ))p" /usr/share/dict/words)"-"$(sed -n "$(( 1 + RANDOM % $MAX_FILE_LINES ))p" /usr/share/dict/words)
    echo "Creating repo: ${ORG}/${REPO_NAME}"
    # Create a repository named ${REPO_NAME} inside the org_name
    gh repo create ${ORG}/${REPO_NAME}
  done
fi