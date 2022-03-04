# Rails Tutorial


~~成果物：https://gentle-shore-22479.herokuapp.com/~~

成果物：https://morning-tor-81081.herokuapp.com/

# 第1章

## 備考

- Cloud9ではなくローカル環境で作業
- Git,GitHub関連の部分は適宜読み替え/読み飛ばし

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

## エラーログ
```bash
$ mkdir environment
$ cd environment
$ rails _6.0.4_ new hello_app
(Gemfile書き換え)
$ cd hello_app
$ bundle _2.2.17_ install
 # => エラーでる
$ bundle _2.2.17_ update
$ bundle _2.2.17_ install
$ rails webpacker:install
 # => めちゃくちゃコンフリクトするけど全部"y"で飛ばす
 # したらできる
```

```bash
rails new したディレクトリ配下に.gitがあるのでGitHubに上げるときにエラーでた
-> 消せばOK -> というかその先でもエラー吐くので素直に直下にプロジェクト置くべき
```

```bash
git push heroku master -> git push heroku develop:master に変更
```

## レビュー
https://github.com/shmn7iii/rails_tutorial/pull/1

```planetext
# コメント
--------------------------------------------------------------------------
・「ファイル末尾には改行を入れる」
    -> 便利な拡張機能もある cf. https://qiita.com/norikt/items/83674fadd79a88bf7824

# FYI
--------------------------------------------------------------------------
・「config/master.keyがアップされてる」
    -> .gitignoreの取り違えミス
```

# 第2章

## 学び

```planetext
・「scaffoldコード」
    -> サクッと作るならでら便利だけどややこしいし読みづらい

・「:userみたいなやつ」
    -> "シンボル"と呼ばれる

・「ユーザーがmicropostをたくさん持つよ」
    -> has_many :microposts | app/models/user.rb

・「micropostは一人のユーザーに属するよ」
    -> belongs_to :user | app/models/micropost.rb
```

## レビュー
https://github.com/shmn7iii/rails_tutorial/pull/2

```planetext
# コメント
--------------------------------------------------------------------------
・「不要ファイルは消していい」
    -> app/assets/stylesheets/users.scss, microposts.scss
       app/helpers/users_helper.rb, microposts_helper.rb

・「シンボルの配列は%記法を用いることが多い」
    -> before_action :set_micropost, only: [:show, :edit, :update, :destroy]
       before_action :set_micropost, only: %i[show, edit, update, destroy]

・「privateメソッドの中身はインデント揃えるのが一般的」
    -> private
       def set_user
         @user = User.find(params[:id])
       end

# FYI
--------------------------------------------------------------------------
・「実際のサービスでは null: false などバリデーションを指定することが多い」
    -> ここ：db/migrate/20220303055523_create_users.rb
       チュートリアル内でもここについて指摘あったのでこの先の章で説明出てくるかも

・「実際のサービスでは t.references :user などと書くことが多い」
    -> ここ：db/migrate/20220303061143_create_microposts.rb
       cf. https://qiita.com/ryouzi/items/2682e7e8a86fd2b1ae47
       メリット：
        ・userではなくuser_idというカラム名を作成してくれる
        ・インデックスを自動で張ってくれる

# 見反映FYI
--------------------------------------------------------------------------
・「デフォルトのテンプレートエンジンは erb よりスッキリな slim がよく使われる」
    -> cf. https://qiita.com/ngron/items/c03e68642c2ab77e7283」
       今回のチュートリアルはerbのまま進める
       HTML苦手マン的にはめちゃくちゃ嬉しいslim
```

# 第3章

## 学び

```planetext
・「.keepファイルについて」
    -> rails new 時に –skip-keeps オプション追加で生成されないようにできる | 参考：https://railsdoc.com/page/rails_new
```
