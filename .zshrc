# setting for zsh
#
# for Vim
export VIMHOME=~/.vim/
# for ctags
#alias ctags=/usr/local/Cellar/ctags/5.8/bin/ctags

#文字コードの設定
LANG=ja_JP.UTF-8
export LANG
export JAVA_OPTS='-Dfile.encoding=UTF-8' # MacのJavaVMはデフォルトSJIS

# その他環境変数
export SHELL=/bin/zsh
PAGER=lv
SVN_EDITOR=vim
export SVN_EDITOR
EDITOR=vim
# Marverics対応。perlのデフォルトバージョンが変わったが必要なライブラリが足りていない？
export VERSIONER_PERL_VERSION=5.12

#alias
alias ll='ls -laG'
alias lR='ls -laRG'
alias rm='rm -i'
alias h='history'
alias hl='highlight'

# alias for git
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gg='git graph'

# local alias for develop
alias RRR='sudo apachectl restart';
hash -d FF=/home/game/git/sg-ffjm

# global alias
alias -g L="| $PAGER"
alias -g G="| grep"
alias -g E="| egrep"
alias -g H="| head"
alias -g T="| tail"
alias -g X="| xargs"
alias -g V="| vim -R -"
alias -g HL="| highlight"

# add cpanm
# use cpanm App::highlight
export PERL_LOCAL_LIB_ROOT=~/perl5
export PERL_MB_OPT="--install_base /Users/masato/perl5"
export PERL5LIB=~/perl5/lib/perl5
export PATH=~/perl5/bin:$PATH
alias -g H="| highlight"

# prompt
# fix ssh env
if [ "$TERM" = "screen" ]; then
  alias fixsshenv='cat ~/.ssh/fix_ssh_env | sh'
  alias ssh='fixsshenv; ssh'
  alias svn='fixsshenv; svn'
else
  export | grep '^SSH_' > ~/.ssh/fix_ssh_env
fi

# VCSの情報を取得するzshの便利関数 vcs_infoを使う
autoload -Uz vcs_info

# 表示フォーマットの指定
# %b ブランチ情報
# %a アクション名(mergeなど)
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
# バージョン管理されているディレクトリにいれば表示，そうでなければ非表示
#RPROMPT="%1(v|%F{green}%1v%f|)"
autoload -U colors
colors
local LPCOLOR='%{%(!.$fg[red].$fg[cyan])%}'
#[ "${REMOTEHOST}${SSH_CONNECTION}" ] && 
#	LPCOLOR='%{%(!.$fg[red].$fg[blue])%}'
    
local RPCOLOR='%{$fg[green]%}'
local DEFAULT=%{$reset_color%}
# 左右プロンプトの定義
PROMPT=$LPCOLOR'[${USER}@${HOST%%.*}] %(!.#.$) '$DEFAULT
RPROMPT=$RPCOLOR'%T[%~]'$DEFAULT
RPROMPT=%1(v|%F{blue}%1v%f|)$RPCOLOR'%T[%~]'$DEFAULT
setopt prompt_subst

# タイトル変更
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST}\007"
    }
    ;;
esac 

# キャッシュの設定
if [ -d ~/.zsh/cache ]; then
    zstyle ':completion:*' use-cache yes
    zstyle ':completion:*' cache-path ~/.zsh/cache
fi

# 保管
autoload -U compinit
compinit

# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# 補完候補が複数ある時に、一覧表示する
setopt auto_list

# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

# カッコの対応などを自動的に補完する
setopt auto_param_keys

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除く
#setopt auto_remove_slash

# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt auto_resume

# ビープ音を鳴らさないようにする
setopt NO_beep

# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

# 内部コマンドの echo を BSD 互換にする
#setopt bsd_echo

# シンボリックリンクは実体を追うようになる
#setopt chase_links

# 既存のファイルを上書きしないようにする
#setopt clobber

# コマンドのスペルチェックをする
#setopt correct

# コマンドライン全てのスペルチェックをする
#setopt correct_all

# =command を command のパス名に展開する
setopt equals

# ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
# (Gitが使いにくくなる)
#setopt extended_glob

# zsh の開始・終了時刻をヒストリファイルに書き込む
#setopt extended_history

# Ctrl+S/Ctrl+Q によるフロー制御を使わないようにする
setopt NO_flow_control

# 各コマンドが実行されるときにパスをハッシュに入れる
#setopt hash_cmds

# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups

# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_ignore_space

# ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt hist_verify

# シェルが終了しても裏ジョブに HUP シグナルを送らないようにする
setopt NO_hup

# Ctrl+D では終了しないようになる（exit, logout などを使う）
setopt ignore_eof

# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types

# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# メールスプール $MAIL が読まれていたらワーニングを表示する
#setopt mail_warning

# ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs

# 補完候補が複数ある時、一覧表示 (auto_list) せず、すぐに最初の候補を補完する
#setopt menu_complete

# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios

# ファイル名の展開で、辞書順ではなく数値的にソートされるようになる
setopt numeric_glob_sort

# コマンド名に / が含まれているとき PATH 中のサブディレクトリを探す
#setopt path_dirs

# 8 ビット目を通すようになり、日本語のファイル名などを見れるようになる
setopt print_eightbit

# 戻り値が 0 以外の場合終了コードを表示する
#setopt print_exit_value

# ディレクトリスタックに同じディレクトリを追加しないようになる
#setopt pushd_ignore_dps

# pushd を引数なしで実行した場合 pushd $HOME と見なされる
#setopt pushd_to_home

# rm * などの際、本当に全てのファイルを消して良いかの確認しないようになる
#setopt rm_star_silent

# rm_star_silent の逆で、10 秒間反応しなくなり、頭を冷ます時間が与えられる
setopt rm_star_wait

# for, repeat, select, if, function などで簡略文法が使えるようになる
setopt short_loops

# デフォルトの複数行コマンドライン編集ではなく、１行編集モードになる
#setopt single_line_zle

# コマンドラインがどのように展開され実行されたかを表示するようになる
#setopt xtrace

# 色を使う
setopt prompt_subst

# シェルのプロセスごとに履歴を共有
setopt share_history

# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

#文字列末尾に改行コードが無い場合でも表示する
unsetopt promptcr

#   コピペの時rpromptを非表示する
setopt transient_rprompt

#  cd -[tab] でpushd
setopt autopushd

# dont use git completion
__git_files() { _files }
