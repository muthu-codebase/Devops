## Inputs:
Github_token=$1
current_repo=$2
PR_number=$3
Source_org="muthu-codebase"

echo "$current_repo"
echo "$PR_number"



## Source org to be fetching the repo
url=https://api.github.com/orgs/$Source_org/repos
repos=($(curl -H "Authorization: Bearer $Github_token" "$url" | jq -r '.[] | .name'))
echo "$repos"


## current repo comments fetch
pull_comment=https://api.github.com/repos/$current_repo/pulls/$PR_number
repo_name=$(curl -H "Authorization: Bearer $Github_token" "$pull_comment" | jq -r '.body')
echo "$repo_name"


IFS=':' read -r -a repo <<< "$repo_name"
rto="${repo[1]}"

for repo_name in "${repos[@]}";do
  if [ "$repo_name" == "$rto" ]; then
    flag=1
    echo "***the repo gets matched going to archive the repo using the post call***"
  fi
done

if [[ "$flag" -eq 0 ]]; then
  echo "the repo not gets matched"
fi 

