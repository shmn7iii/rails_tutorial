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
