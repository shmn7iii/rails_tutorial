#  第6章

## 学び

- 「コントローラ名には複数形を使い、モデル名には単数形を用いるという慣習」  
    忘れがち  
    テーブル名は複数
    
- 「マイグレーションファイルのタイムスタンプ」  
    これなんだろうってずっと思ってたけど、複数人開発でのコンフリクトを避けるためらしい  
    なるほどなぁ

- 「created_at と updated_at」  
    「マジックカラム」と呼ばれる

- 「Railsコンソール サンドボックスモード」  
    ```bash
    $ rails console --sandbox
    Any modifications you make will be rolled back on exit
    ```
    全ての変更が自動でロールバックされる(=DBに反映させない)モード

- 「User.new / .save / .create / .destroy」  
    `.new` でメモリ上でオブジェクトを作成  
    `.save` でデータベースへ格納 true/falseを返してくれる  
    `.create` は new と save を両方やってくれる 戻り値はオブジェクト自身  
    `.destroy` は create の逆 ただしメモリ上には残る 戻り値はオブジェクト自身  

- 「User.find / .find_by / .first / .all」  
    `.find` idを引数にとってオブジェクトを返す  
    `.find_by` 任意の属性を引数にとってオブジェクトを返す  
    `.first` DBの最初のオブジェクトを返す  
    `.all` DBの全てのオブジェクトを返す  

    この辺り、チャレキャラでなんもわからんまま適当に触ってた。
    そういうの「ダックタイピング（duck typing）」と呼ぶらしい。  
    > 「もしアヒルのような容姿で、アヒルのように鳴くのであれば、それはもうアヒルだろう」

- 「User.update / .update_attribute / .属性」  
    `.update` 変えたい内容をハッシュで引数にとって更新、保存に成功でture/false を返す  
    `.update_attribute` 特定の属性のみ更新 updateだと検証失敗で全部ないなるのでそれ回避  
    `.属性` 指定内容を更新してその内容を返す ＊savaが必要

- 「modelの検証」  
    modelファイルで `validates` メソッド使って設定する
    test は不正なオブジェクトを `valid?` して `asset_not` でテストする

- 「%w[]」  
    文字列の配列を簡単に作れる  
    ```ruby
    %w[foo bar baz]
    # => ["foo", "bar", "baz"]
    ```
- 「一意性のテスト」  
    はメモリ上の保存したオブジェクトだけでは検証できないので実際にDBへ保存する非通用がある

- 「データベースの設定はマイグレーションで更新する」  
    `generate migration`でマイグレーションファイルが生成されるのでそこに変更内容を書く  
    したら `db:migration` で更新できる

- 「インデックスがないと全表スキャンする羽目になる」  
    つまり全部を端から端まで探すこと  
    大規模になると全然無理

- 「DBに保存されるメアドは全部小文字にしたいぜ」  
    Active Recordのコールバック（callback）メソッドを利用  
    このメソッドは、ある特定の時点で呼び出されるメソッド  
    この場合はその中でも `before_save` を利用
    ```ruby
    # app/models/user.rb
    class User < ApplicationRecord
      before_save { self.email = email.downcase }
      ...
    end
    ```

- 「多重代入」  
    これ  
    ```ruby
    user.password = @user.password_confirmation = "a" * 5
    ```

- 「has_secure_password」  
    モデルに追加することでセキュアなパスワードを扱えるようになる  
    パスワードはハッシュ化されて保存される  
    `authenticate` で軽い認証もできる
