# transfer-gitlab-to-github

将一个Git仓库方便地迁移到另一个Git仓库的脚本(如GitLab迁移到GitHub) \
支持批量修改commit用户名与邮箱
## 注意
运行前请先打开脚本，修改`原用户名`、`原邮箱`、`新用户名`、`新邮箱`！
## 使用方法
```shell
bash <(curl -Ls https://raw.githubusercontent.com/pplulee/transfer-git-repo/main/git-transfer.sh)
```
或者
```shell
curl -Ls https://raw.githubusercontent.com/pplulee/transfer-git-repo/main/git-transfer.sh | bash
```
或者 \
下载或clone本仓库，然后运行`git-transfer.sh`脚本