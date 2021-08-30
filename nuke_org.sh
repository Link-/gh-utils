#!/bin/bash
# nuke_org.sh
# 
# This script will remove all repositories in the designated org.
#
# Usage:
#   nuke_org.sh <org_name>
#
# Example:
#   nuke_org.sh my-org
#
declare ORG=$1
echo -e "WARNING: Deleting all repos in: ${ORG}"
# prompt user for confirmation
read -p "You cannot recover from this. Are you sure? [(y)es|(n)o]" -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # Loop and delete all the repositories in an organisation
  REPOS=$(gh api -X GET "/orgs/inner-sanctum/repos?per_page=100" | jq -cr ".[].full_name")
  for repo in $REPOS; do
    echo "Deleting: ${repo}"
    gh api -X DELETE "/repos/${repo}" | jq -r .message
  done
fi
# echo newline
echo -e "\nDone!"
