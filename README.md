# [Ruby on Rails Tutorial](https://railstutorial.jp/)


~~成果物：https://gentle-shore-22479.herokuapp.com/~~  
成果物：https://morning-tor-81081.herokuapp.com/

## 学び

[第1章「ゼロからデプロイまで」](/doc/chap1.md)  
[第2章「Toyアプリケーション」](/doc/chap2.md)  
[第3章「ほぼ静的なページの作成」](/doc/chap3.md)  
[第4章「Rails風味のRuby」](/doc/chap4.md)  
[第5章「レイアウトを作成する」](/doc/chap5.md)  
[第6章「ユーザーのモデルを作成する」](/doc/chap6.md)  
[第7章「ユーザー登録」](/doc/chap7.md)  
[第8章「基本的なログイン機構」](/doc/chap8.md)  
[第9章「発展的なログイン機構」](/doc/chap9.md)  

```text
↓↓↓まだ↓↓↓  
[第10章「ユーザーの更新・表示・削除」](/doc/chap10.md)  
[第11章「アカウントの有効化」](/doc/chap11.md)  
[第12章「パスワードの再設定」](/doc/chap12.md)  
[第13章「ユーザーのマイクロポスト」](/doc/chap13.md)  
[第14章「ユーザーをフォローする」](/doc/chap14.md)  
```

## 環境構築

```bash
# homebrew
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# rbenv,ruby-buildをインストール
$ brew install rbenv ruby-build

# rbenvの初期設定
$ rbenv init
　# zshrcに出力内容を書き込み

# チェック
$ curl -fsSL https://github.com/rbenv/rbenv-installer/raw/main/bin/rbenv-doctor | bash

# Ruby本体をインストール
$ rbenv install 2.6.3

# グローバルを2.6.3に設定
$ rbenv global 2.6.3

# Ruby gems (bundler) をインストール
$ gem install bundler -v 2.2.17

# SQLite3 (macに最初から入ってる
$ sqlite3 --version

# node.js (入ってないのでインストールしよう
# nodeを管理するnodebrew
$ brew install nodebrew

# 初期設定
$ nodebrew setup
  # 出力内容をzshrcに書き込み

# 安定版をインストール
$ nodebrew install-binary stable

# インストールしたバージョンを確認
$ nodebrew ls
  # バージョンを確認してそれを次で使う

# 利用バージョンを指定
$ nodebrew use v16.14.0

# 再読み込み
$ source ~/.zshrc

# 確認
$ node --version

# yarn (入ってないのでインストール
$ npm install -g yarn

# 確認
$ yarn -v

# railsをインストール
$ gem install rails -v 6.0.4

# 確認
$ rails --version
```
