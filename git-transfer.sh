#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PLAIN='\033[0m'
BLUE="\033[36m"

echo -e "${BLUE}请输入${YELLOW}来源Git仓库${PLAIN}地址:"
read -e gitlab_url
echo -e "${BLUE}正在${YELLOW}克隆${PLAIN}仓库..."
git clone $gitlab_url
repo_name=$(basename -s .git "$gitlab_url")
cd $repo_name
echo -e "${BLUE}请输入${YELLOW}要导入的分支${PLAIN}:"
read -e gitlab_branch_name
echo -e "${BLUE}正在${YELLOW}切换到${PLAIN}分支..."
git checkout $gitlab_branch_name
echo -e "${BLUE}请输入${YELLOW}目标Git仓库${PLAIN}地址:"
read -e github_url
change_author_name=false
echo -e "${BLUE}是否需要批量修改commit的${YELLOW}用户名和邮箱${PLAIN}?(y/N)"
read -e change_author_name
if [ "$change_author_name" = "y" ]; then
  echo -e "${BLUE}请输入${YELLOW}旧邮箱${PLAIN}:"
  read -e old_author_email
  echo -e "${BLUE}请输入${YELLOW}新用户名${PLAIN}:"
  read -e new_author_name
  echo -e "${BLUE}请输入${YELLOW}新邮箱${PLAIN}:"
  read -e new_author_email

  filter="if [ \"\$GIT_COMMITTER_EMAIL\" = \"$old_author_email\" ]; then
      export GIT_COMMITTER_NAME=\"$new_author_name\"
      export GIT_AUTHOR_NAME=\"$new_author_name\"
      export GIT_COMMITTER_EMAIL=\"$new_author_email\"
      export GIT_AUTHOR_EMAIL=\"$new_author_email\"
    fi
    git commit-tree \"\$@\""

  git filter-branch --commit-filter "$filter" HEAD
fi
echo -e "${BLUE}正在${YELLOW}推送到${PLAIN}目标仓库..."
git remote set-url origin $github_url
git push -u origin $gitlab_branch_name:main
cd ../
echo -e "${BLUE}删除${YELLOW}本地仓库${PLAIN}..."
rm -rf $repo_name