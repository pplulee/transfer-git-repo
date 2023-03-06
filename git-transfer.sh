#!/bin/bash
echo "请输入GitLab Repo地址"
read -e gitlab_url
git clone $gitlab_url
repo_name=$(basename -s .git "$gitlab_url")
cd $repo_name
echo "请输入GitLab 分支名称"
read -e gitlab_branch_name
git checkout $gitlab_branch_name
echo "请输入Github Repo地址"
read -e github_url
git filter-branch --commit-filter '
    if [ "$GIT_AUTHOR_EMAIL" = "原用户名" ];
    then
        GIT_AUTHOR_EMAIL="新邮箱";
        GIT_COMMITTER_EMAIL="新邮箱";
        GIT_AUTHOR_NAME="新用户名";
        GIT_COMMITTER_NAME="新用户名";
        git commit-tree "$@";
    else
        git commit-tree "$@";
    fi;' HEAD

git remote set-url origin $github_url
git push -u origin $gitlab_branch_name:main
cd ../
rm -rf $repo_name