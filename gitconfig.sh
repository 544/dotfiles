#!/bin/sh
# this is git config set script

# コミット時のユーザID
#git config --global user.name "John Doe"
#git config --global user.email johndoe@example.com

# コミットコメント編集用エディタ
git config --global core.editor vi

# log diff 利用時のページャ
# nkfかますとうまく動かない・・・
#git config --global core.pager 'lv -c | nkf -w -x'
git config --global core.pager 'lv -c '

# 色設定
git config --global color.ui true

# alias
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch

# Untracked filesを表示せず，not stagedと，stagedだけの状態を出力する
git config --global alias.stt status -uno
# 行ごとの差分じゃなくて，単語レベルでの差分を色付きで表示する
git config --global alias.difff diff --word-diff
# いい感じのグラフでログを表示
git config --global alias.graph 'log --graph --date-order -C -M --pretty=format:"<%h> %ad %Cgreen%d%Creset %s (%Cred%an%Creset)" --date=local'
git config --global alias.graph-all 'log --graph --date-order -C -M --pretty=format:"<%h> %ad %Cgreen%d%Creset %s (%Cred%an%Creset)" --date=local --all'
#git config --global alias.graph log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'
# 上の省略形
#git config --global alias.gr log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'

exit

# 以下メモ
#color.diff=auto
#color.interactive=auto
#color.status=auto
#color.branch=auto
#color.ui=true
#alias.st=status
#alias.ci=commit
#alias.co=checkout
#alias.w=whatchanged
#alias.b=branch
#alias.dc=diff --cached
#alias.url=config --get remote.origin.url
#alias.graph=log --graph --date-order -C -M --pretty=format:"<%h> %ad %Cgreen%d%Creset %s (%Cred%an%Creset)" --date=local
#alias.graph-all=log --graph --date-order -C -M --pretty=format:"<%h> %ad %Cgreen%d%Creset %s (%Cred%an%Creset)" --date=local --all
#push.default=tracking
#core.pager=lv -c | nkf -w -x
#core.repositoryformatversion=0
#core.filemode=true
#core.bare=false
#core.logallrefupdates=true
#remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
#remote.origin.url=https://github.com/544/dotfiles.git
#branch.master.remote=origin
#branch.master.merge=refs/heads/master
