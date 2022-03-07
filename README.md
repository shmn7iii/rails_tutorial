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

```text
rails new したディレクトリ配下に.gitがあるのでGitHubに上げるときにエラーでた
-> 消せばOK -> というかその先でもエラー吐くので素直に直下にプロジェクト置くべき
```

```text
git push heroku master -> git push heroku develop:master に変更
```

## レビュー
https://github.com/shmn7iii/rails_tutorial/pull/1

```text
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

```text
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

```text
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

```text
・「.keepファイルについて」
    -> rails new 時に –skip-keeps オプション追加で生成されないようにできる
       cf. https://railsdoc.com/page/rails_new

・「railsコマンド短縮形」
    完全なコマンド      短縮形
    $ rails server    $ rails s
    $ rails console   $ rails c
    $ rails generate  $ rails g
    $ rails test      $ rails t
    $ bundle install  $ bundle

・「rails generate でミスった時は rails destroy で元に戻せる」
    -> dbもいじっちゃってた時は rails db:rollback でひとつ戻る
       いっちばん最初に戻したい時は rails db:migrate VERSION=0

・「テストは大事」
    -> | アプリケーションを開発しながらテストスイート（Test Suite） をみっちり作成しておけば、
       | いざというときのセーフティネットにもなり、それ自体がアプリケーションのソースコードの
       |「実行可能なドキュメント」にもなります。
       コラムも為になる：https://railstutorial.jp/chapters/static_pages?version=6.0#aside-when_to_test

・「Ruby< DRY（Don’t Repeat Yourself: 繰り返すべからず）」
    -> 繰り返しを追放してコードをDRY（=よく乾かす）しよう

・「erb = Embedded Ruby」
    -> 埋め込みRuby
       <% ... %>  : 処理のみ
       <%= ... %> : 出力もする
       第3章ではこれを上手く使って「なんちゃって動的ページ」を作った

・「root_url というrailsヘルパーがある」
    -> config/route.rb で root 'static_pages#home' みたいに指定すれば使える

・「テストには setupメソッド がある」
    -> 各テストが実行される直前で実行されるメソッド

・「テスト駆動開発では『 red ・ green ・ REFACTOR 』サイクルを繰り返す」
    -> 失敗するテスト → テストが成功するコード → リファクタリング

・「static_pages_helper は消したらまずそう」
    -> https://github.com/shmn7iii/rails_tutorial/commit/636fe953db6503633dae8eee7a01560da272c133
       消したらテスト失敗するようになった

・「minitest-reporter、めっちゃ見やすい」
    -> https://github.com/shmn7iii/rails_tutorial/commit/f631b021e09d76cf9a62b303fc1b7f94026aa7bc

・「Guard、便利」
    -> https://github.com/shmn7iii/rails_tutorial/commit/31a703e003c99a0cc38d10b57e0acf53b93cdd54
       テストが謎に失敗する時はSpringを再起動するといい
       bin/spring stop
```

# 第4章

## 学び
```text
・「カスタムヘルパー」
    -> ユーザー定義の組み込み関数みたいな
       ヘルパーってなんだろうと思ってたけど文字通りヘルパーだった

・「末尾が疑問符のメソッド」
    -> 論理値を返すメソッドは慣例として末尾に疑問符をつける

・「Rubyではあらゆるものがオブジェクト」
    -> false, nil のみ、オブジェクトそのものの理論値がfalse
       その他全てのオブジェクトはtrue => 0 や[](空のarray)などもtrueになる
       !!をつけるとどんなオブジェクトも強制的に理論値に変換できる

・「Rubyのメソッドには暗黙の戻り値がある」
    -> 最後に評価された式が戻り値になる

・「モジュール」
    -> 関連したメソッドをまとめる方法の１つ
       includeメソッドを使って読み込む（ミックスイン（mixed in）とも呼ぶ）

・「破壊的メソッドには感嘆符」
    -> sortメソッドなどにおいて
       list.sort  : list自身は変化なし
       list.sort! : list自身が書き換えられる

・「Rubyでは異なる型でも同一配列内に共存できる」
    -> 安全性的にいいかどうかは置いといて。

・「範囲を配列に」
    -> (0..9).to_a で配列が作られる (to_a = to_array)

・「ブロックはdo..endで表す」
    -> 一行しかなかったら{}でOK

・「mapメソッド」
    -> 渡されたブロックを配列や範囲に適用する
       cf. https://qiita.com/massaaaaan/items/d90d10cb023bedc74fb2

・「“symbol-to-proc”」
    -> >> %w[A B C].map { |char| char.downcase }
       => ["a", "b", "c"]
       >> %w[A B C].map(&:downcase)
       => ["a", "b", "c"]
       &:downcase で省略記法が使えるよというお話

・「ハッシュの最初と最後に空白を追加」
    -> 慣習。意味はない。
       user = { "first_name" => "Michael", "last_name" => "Hartl" }

・「Railsではハッシュのキーにシンボルを使うのが一般的」
    -> user = { :name => "Michael Hartl", :email => "michael@example.com" }
       Ruby 1.9からは以下でも表記可能
       user = { name: "Michael Hartl", email: "michael@example.com" }
       基本こっち

・「引数の最後のハッシュは波括弧を省略できる」
    -> user = User.new(name: "Michael Hartl", email: "mhartl@example.com")
       みたいな時に便利で強力 (Userクラスのinitializeメソッドで引数にハッシュを設定)
       一般に「マスアサインメント（mass assignment）」と呼ばれる

・「'p :name' = 'puts :name.inspect'」
    -> オブジェクトを表示するために inspect がある、省略は p

・「実は、Ruby では丸カッコは使用してもしなくても構いません」
    -> 実は。

・「実は、ハッシュがメソッド呼び出しの最後の引数である場合は、波カッコを省略できます」
    -> 実は。

・「実は、Rubyは改行と空白を区別していません」

・「Hashのコンストラクタはハッシュのデフォルト値を引数にとる」
    -> Arrayみたいに初期値ではない

・「組み込みクラスの変更はきわめて強力なテクニックですが、大いなる力には大いなる責任が伴います。
   このため、真に正当な理由がない限り、組み込みクラスにメソッドを追加することは無作法であると
   考えられています」

・「Railsは確かにRubyで書かれているが、既にRubyとは別物である」
```

## レビュー

https://github.com/shmn7iii/rails_tutorial/pull/5

```text
一部は”学び”セクションに追記

・「<a> link」
  -> rails だし link_to を使った方がいい
```
