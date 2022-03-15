#  第11章

## 学び

- 「アカウントアクティベーションやらパスワードリセットのメール、mailerでできる」  
    コントローラーと同じノリで作れる

- 「メールプレビュー」  
    > Railsでは、特殊なURLにアクセスするとメールのメッセージをその場でプレビューすることができます。メールを実際に送信しなくてもよいので大変便利です。
    
    config/environments/development.rb
    ```ruby
    # ローカル環境
    host = 'localhost:3000'
    config.action_mailer.default_url_options = { host: host, protocol: 'http' }
    ``` 

- 「【メタプログラミング】 `send` メソッド」  
    渡されたオブジェクトに「メッセージを送る」ことによって、呼び出すメソッドを動的に決めることができる
    ```ruby
    >> user = User.first
    >> user.activation_digest
    => "$2a$10$4e6TFzEJAVNyjLv8Q5u22ensMt28qEkx0roaZvtRcp6UZKRM6N9Ae"
    >> user.send(:activation_digest)
    => "$2a$10$4e6TFzEJAVNyjLv8Q5u22ensMt28qEkx0roaZvtRcp6UZKRM6N9Ae"
    >> user.send("activation_digest")
    => "$2a$10$4e6TFzEJAVNyjLv8Q5u22ensMt28qEkx0roaZvtRcp6UZKRM6N9Ae"
    >> attribute = :activation
    >> user.send("#{attribute}_digest")
    => "$2a$10$4e6TFzEJAVNyjLv8Q5u22ensMt28qEkx0roaZvtRcp6UZKRM6N9Ae"
    ```
    attribute変数で式展開することで `user.send("#{attribute}_digest")` で 
    `activation_digest` が呼び出される

    今回ではこれが
    ```ruby
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    ```
    こうなって
    ```ruby
    def authenticated?(remember_token)
      digest = self.send("remember_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(remember_token)
    end
    ```
    こうなる
    ```ruby
    def authenticated?(attribute, token)
      digest = send("#{attribute}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end
    ```
    これで `remember_digest` だろうと `activation_digest` だろうと、`attribute` 引数
    に上手く渡せさえすればこのメソッド1つで済む

- 「アクティベーションはコントローラーのうちedit」  
    メールで送られたURLをクリックする形＝GETリクエストを送信するので

- 「assignメソッドを使えばテスト内からもインスタンス変数へアクセスできるようになるが…」  
    assignsメソッドはRails 5以降はデフォルトのRailsテストで非推奨化された  
    rails-controller-testingというgemを用いることで現在でも利用できる  

- 「本番環境でメールを送信するアドオンを追加する手順」  
    クレカの登録必須と言われたのでスキップします

## レビュー

### コメント

- 「styleseet配下の未使用ファイル」  
    毎回消し忘れる

- 「未使用helperファイル」  
    消すとテストがとおらなくなるのでチュートリアルでは残します

- 「`%i[index, edit, update, destroy]`」  
    これも忘れてた

- 「インデント」  
    こっちの方がいい
    ```diff
    - patch user_path(@user), params: { user: { name:  "",
    -                                       email: "foo@invalid",
    -                                       password:              "foo",
    -                                       password_confirmation: "bar" } }
    + patch user_path(@user), params: {
    +   user: { name: '',
    +           email: 'foo@invalid',
    +           password: 'foo',
    +           password_confirmation: 'bar' }
    +}
    ```

### FYI

- 「pagination」  
    みたいなやつで、`kaminari` がよく使われる
