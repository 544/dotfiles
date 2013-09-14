#!/bin/sh
# this is git config set script

# コミット時のユーザID
#git config --global user.name "John Doe"
#git config --global user.email johndoe@example.com

# コミットコメント編集用エディタ
git config --global core.editor vi

# log diff 利用時のページャ
#git config --global core.pager lv

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
#git config --global alias.graph log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'
# 上の省略形
#git config --global alias.gr log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'
