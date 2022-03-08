#  第8章

## 学び

- 「認証システム（Authentification System）」  
    ブラウザがログイン状態を保持し、ブラウザが閉じられると破棄される

- 「認可モデル（Authorization Model）」  
    ログイン済みユーザーのみが見れるページ、扱える機能の制御、ログイン状態に応じたヘッダー、などなど

- 「ログイン機能の作り方（簡易版）」  
    Sessionコントローラーで作る  
    newでセッションを作って  
    createでログインして（user変数にUserモデルを丸ごと入れる）  
    destroyでログアウトする（変数を破棄）  
    `session[:user_id]` の形でログインユーザーのIDを取得してDBに問い合わせる  
    動的なやつは erb で if-else 使っていい感じに

- 「現在のユーザーの取得」  
    find_byを使うことでユーザーが見つからなかった場合も例外を発生させずにnilが返るようにする
    ```ruby
    def current_user
      if session[:user_id]
        User.find_by(id: session[:user_id])
      end
    end
    ```
    これだと `current_user` 使うたびにDBに問い合わせるのでだるい  
    -> Rubyの慣習に従い、User.find_byの実行結果をインスタンス変数に保存する工夫  
    > いわゆるメモ化
    ```ruby
    def current_user
      if session[:user_id]
        if @current_user.nil?
          @current_user = User.find_by(id: session[:user_id])
         else
          @current_user
        end
      end
    end
    ```
    これなら2度目以降の呼び出しでインスタンス変数がnilでないのでそいつがそのまま返る

    さらに一行にもできる
    ```ruby
    def current_user
      if session[:user_id]
        @current_user ||= User.find_by(id: session[:user_id])
      end
    end
    ```
    こういうのを「短絡評価（short-circuit evaluation）」と呼ぶ  
    > `||`式を左から右に評価し、演算子の左の値が最初にtrueになった時点で処理を終了するという評価法

- 「fixture（フィクスチャ）」  
    テストに必要なデータをtestデータベースに読み込んでおくことができる  
    今回は test/fixture/users.yaml でYAML形式で保存

- 「safe navigation演算子（ぼっち演算子）」  
    `obj && obj.method` のようなパターンを` obj&.method` のように凝縮した形で書ける
    ```diff
    - if user && user.authenticate(params[:session][:password])
    + if user&.authenticate(params[:session][:password])
    ```

## レビュー

### FYI

- 「『`||=`』と『`instance_variable_defined?`』」  
    ```ruby
    # ||=のメモ化
    def current_user
      @current_user ||= find_by(id: 1)
    end

    # instance_variable_defined?のメモ化
    def current_user
      return @current_user if instance_variable_defined? :@current_user
      @current_user = find_by(id: 1)
    end
    ```
    おんなじようなことやってくれるけど...  
    検索結果（今回は `find_by(id: 1)` の結果）が `nil` の場合、
    `instance_variable_defined` は `find_by` を呼ばずに `nil` を返す  
    つまり `||=` は結果が `nil` だった場合はメモ化されない  

    まとめると  
    > 右辺に `nil` が返ってくる可能性がある式でメモ化を行う場合、
    > 定義済みの `nil` をメモ化したければ `instance_variable_defined?` を使うと良い

    参考：[「Rubyのメモ化における「||=」と「instance_variable_defined?」の違い」]()

- 「.save / .save!」  
    保存に失敗した時例外を吐かせたい（エラーを出したい）場合は `save!`   
    処理を分岐させたい場合は `save`
