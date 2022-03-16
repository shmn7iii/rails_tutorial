#  第13章

## 学び

- 「リレーション付きのポスト」  
    ```ruby
    @user = users(:michael)

    # 動きはする、けど慣例的に正しくない
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)

    # こっちがいいよ
    @micropost = @user.microposts.build(content: "Lorem ipsum")
    ```
    こうするとユーザーを通してマイクロポストを作れる  
    
    ＊`new` メソッド同様、`build` メソッドはオブジェクトを返すがデータベースには反映されない

- 「fixtureも関連付けできる」  
    ```yaml
    orange:
      content: "I just ate an orange!"
      created_at: <%= 10.minutes.ago %>
      user: michael
    ```
    ```yaml
    michael:
      name: Michael Example
      email: michael@example.com
      ...
    ```


- 「モデルに順序付けできる」  
    `app/model/microposts.rb` 本体にかける
    ```ruby
    default_scope -> { order(created_at: :desc) }
    ```
    orderの引数は生のSQLでも書ける


- 「ラムダ式」  
    Procやlambda（もしくは無名関数）とも呼ばれる
    ```ruby
    >> -> { puts "foo" }
    => #<Proc:0x007fab938d0108@(irb):1 (lambda)>
    >> -> { puts "foo" }.call
    foo
    => nil
    ```


- 「ユーザー消したらポストも消したいなあ」  
    `has_many` の後ろに `dependent: :destroy` をつけるといい
    ```ruby
    has_many  :microposts, dependent: :destroy
    ```


- 「response.bodyを使ったテスト  
    `assert_select` ではどのHTMLタグを探すのか伝える必要がある  
    `assert_match` では必要ない、どこかしらにあればOK


- 「ふとエラーが止まらなくなった」  
    原因探ると `%i[index, ...]` にしたコミット（
    [これ](https://github.com/shmn7iii/rails_tutorial/commit/ec61adf264ae0f89c980455b260cba372e4ea7ca) と
    [これ](https://github.com/shmn7iii/rails_tutorial/commit/270568d35397aaa6474bb9778ed55427270e91ba)
    ）だった  
    理由はまったくわからないけど変更したらちゃんとテストするようにしよう  
    ```
    ERROR["test_password_resets", #<Minitest::Reporters::Suite:0x00007fb9eedf9fd0 @name="PasswordResetsTest">, 4.535359999979846]
     test_password_resets#PasswordResetsTest (4.54s)
    ActionView::Template::Error:         ActionView::Template::Error: undefined method `errors' for nil:NilClass
                app/views/shared/_error_messages.html.erb:1
                app/views/password_resets/edit.html.erb:8
                app/views/password_resets/edit.html.erb:6
                test/integration/password_resets_test.rb:27:in `block in <class:PasswordResetsTest>'
    ```

    この後でもエラー止まらん現象（上記とは別内容）出たけど、自分で `%i[create, destroy]` に書き換えていたところを
    `[:create, :destroy]` へ戻したら通った  
    
    仕様の違いがある？

- 「pluralize」
    ```ruby
    pluralize(current_user.microposts.count, "micropost")
    ```
    こうすると  “1 micropost” や “2 microposts”  と表示してくれる。便利。


- 「SQLインジェクション」  
    任意のSQL文を挿入されちゃったら大変なあれ。
    ```ruby
    Micropost.where("user_id = ?", id)
    ```
    疑問符をつけることで、`id` 変数がエスケープされこの問題を回避することができる


- 「`request.referrer || root_url`」
    `request.referrer` はひとつ前のページを返してくれる  
    たとえばDeleteリクエストを送ったページ  
    便利

    もしひとつ前のページが見つからなくても、` || root_url` によってrootに飛ばされる仕組み

- 「Active Storage」
    便利なファイルアップロード機能  
    modelファイルで `has_one_attached` や `has_many_attached` オプションをつけると紐づく

    validation機能はない。Gemが使える
    ```ruby
    gem 'active_storage_validations', '0.8.2'
    ```

    負荷回避にもユーザビリティ的にもクライアント側でもvalidateすべき


- 「画像のリサイズ」
    ImageMagickくんがやってくれる。便利。  
    対応Gem入れてvariantメソッドを使うと、キャッシュ作って処理してくれる。便利。

- 「user.microposts.count」  
    > 最後の課題はマイクロポストの投稿数を表示することですが、これはcountメソッドを使うことで解決できます。大事なことは、countメソッドではデータベース上のマイクロポストを全部読みだしてから結果の配列に対してlengthを呼ぶ、といった無駄な処理はしていないという点です。そんなことをしたら、マイクロポストの数が増加するにつれて効率が低下してしまいます。そうではなく、（データベース内での計算は高度に最適化されているので）データベースに代わりに計算してもらい、特定のuser_idに紐付いたマイクロポストの数をデータベースに問い合わせています。（それでもcountメソッドがアプリケーションのボトルネックになるようなことがあれば、さらに高速なcounter cacheを使うこともできます。）


## レビュー

[第14章](/doc/chap14.md)でまとめて
