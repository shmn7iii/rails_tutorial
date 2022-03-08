#  第7章

## 学び

- 「`<%= debug(params) if Rails.env.development? %>`」  
    開発環境でのみデバッグ情報が表示される  
    環境の判定はここで取る  
    ```ruby
    if Rails.env.development?
    ```

- 「byebugのdebugger」  
    コード内に差し込むことで任意のタイミングでデバッグ用プロンプトを呼び出せる  
    便利

- 「キーワード引数」  
    ＊ Ruby2.0で導入  
    従来  
    ```ruby
    def greet(first_name, last_name, age)
    puts "#{first_name} #{last_name}、#{age}歳です。" # -> 山田 太郎、20歳です。
    end
    greet("山田", "太郎", 20)
    ```
    キーワード引数  
    ```ruby
    def greet(first_name:, last_name:, age:)
    puts "#{first_name} #{last_name}、#{age}歳です。" # -> 山田 太郎、20歳です。
    end
    greet(first_name: "山田", last_name: "太郎", age: "20")
    ```
    引数を渡す時、キーワードを指定するから分かりやすい＆順序を気にしなくていい  
    便利  

    参考：[「Rubyのキーワード引数」](https://tokitsubaki.com/ruby-keyword-arguments/531/)


- 「Strong Patameter」  
    paramハッシュを丸ごと渡すのは危険  
    必須のパラメータと許可されたパラメータを指定することができる  
    今回だったらname,email,password,password_confirmationを許可する的な

- 「`assert_no_difference`」  
    doの前後で引数内容が変わらないよねを検証  
    今回だとユーザー数を「失敗するユーザー作成」の前後で比べる

- 「flash」  
    flash変数に代入したメッセージは、リダイレクトした直後のページで表示できるようになる  

- 「本番環境のSSL化」  
    config/environments/production.rb で `config.force_ssl = true` を書くだけ  
    チャレキャラでCloudFront駆使して迂回させまくった時とは違う解法
