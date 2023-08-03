## Inputs
Github_token=$1
current_repo=$2
PR_number=$3
Source_org="muthu-codebase"

echo "$current_repo"
echo "$PR_number"


## Fe-Agents organisation fetching all the repos_name  :
urlSource_Repo=https://api.github.com/orgs/$Source_org/repos
repo_list=$(curl -s -H "Authorization: token $Github_token" "$urlSource_Repo" | jq -r '.[] | .name')


## fetching the comments:
fetch_comment=https://api.github.com/repos/$current_repo/pulls/$PR_number
repo_name=$(curl -H "Authorization: Bearer $Github_token" "$fetch_comment" | jq -r '.body')
echo "$repo_name"


# Userinput reponame :
IFS=':' read -ra repo_name <<< "$repo_name"
repository_name="${repo_name[1]}"

for source_reponame in "${repo_list[@]}";do
  if [ "$source_reponame" == "$repository_name" ]; then 
    flag=1
    echo "*** Reponame gets matched going to Archive the repo by using the post call ***"
  fi
done

if [[ "$flag" -eq 0 ]]; then
  echo "***Please provide the valid Repository name***"
fi 
