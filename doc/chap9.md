#  第9章

## 学び

- 「CookieにそのまんまユーザーID載せるのは危険」  
    署名付きCookieを使うと暗号化してくれる  
    ```ruby
    cookies.signed[:user_id] = user.id
    ```
    永続化もさせるのでこうなる  
    ```ruby
    cookies.permanent.signed[:user_id] = user.id
    ```

- 「`if (user_id = session[:user_id])`」  
    「（ユーザーIDにユーザーIDのセッションを代入した結果）ユーザーIDのセッションが存在すれば」  
    比較のタイポじゃないよ

- 「ログイン＝セッション作ると同時にrememberする」  
    ログアウト＝セッション破棄でforgetする

- 「Rubyの三項演算子」  
    「論理値? ? 何かをする : 別のことをする」  
    ```ruby
    if boolean?
      var = foo
    else
      var = bar
    end

    # これは次のようになる

    var = boolean? ? foo : bar
    ```

- 「テストし忘れてないかなの確認にあえて例外発生させる」  
    例外が発生したらテストが通らないので...

    テスト通らなくなった = 例外が発生した = 該当コードブロックはテストに含まれる

    ことがわかる

## レビュー

### FYI

- 「`update_attribute` は非推奨」  
    validationが効かないので Rails 6.1系以降からは削除されている  
    通常は `update` / `update!` を例外の有無で使い分ける
