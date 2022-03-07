# 第4章

## 学び

- 「カスタムヘルパー」  
    ユーザー定義の組み込み関数みたいな  
    ヘルパーってなんだろうと思ってたけど文字通りヘルパーだった

- 「末尾が疑問符のメソッド」  
    論理値を返すメソッドは慣例として末尾に疑問符をつける

- 「Rubyではあらゆるものがオブジェクト」  
    false, nil のみ、オブジェクトそのものの理論値がfalse  
    その他全てのオブジェクトはtrue  => **0 や[](空のarray)などもtrueになる**  
    !!をつけるとどんなオブジェクトも強制的に理論値に変換できる

- 「Rubyのメソッドには暗黙の戻り値がある」  
    最後に評価された式が戻り値になる

- 「モジュール」  
    関連したメソッドをまとめる方法の１つ  
    includeメソッドを使って読み込む（ミックスイン（mixed in）とも呼ぶ）

- 「破壊的メソッドには感嘆符」  
    sortメソッドなどにおいて
    ```text
    list.sort  : list自身は変化なし
    list.sort! : list自身が書き換えられる
    ```

- 「Rubyでは異なる型でも同一配列内に共存できる」  
    安全性的にいいかどうかは置いといて。

- 「範囲を配列に」  
    `(0..9).to_a` で配列が作られる (to_a = to_array)

- 「ブロックはdo..endで表す」  
    一行しかなかったら{}でOK

- 「mapメソッド」  
    渡されたブロックを配列や範囲に適用する  
    cf. https://qiita.com/massaaaaan/items/d90d10cb023bedc74fb2

- 「“symbol-to-proc”」  
    ```ruby
    %w[A B C].map { |char| char.downcase }
    # => ["a", "b", "c"]

    %w[A B C].map(&:downcase)
    # => ["a", "b", "c"]
    ```
    &:downcase で省略記法が使えるよというお話

- 「ハッシュの最初と最後に空白を追加」  
    慣習。意味はない。  
    ```ruby
    user = { "first_name" => "Michael", "last_name" => "Hartl" }
    ```

- 「Railsではハッシュのキーにシンボルを使うのが一般的」  
    ```ruby
    user = { :name => "Michael Hartl", :email => "michael@example.com" }

    # Ruby 1.9からは以下でも表記可能
    user = { name: "Michael Hartl", email: "michael@example.com" }
    ```

- 「引数の最後のハッシュは波括弧を省略できる」  
    ```ruby
    user = User.new(name: "Michael Hartl", email: "mhartl@example.com")
    ```
    みたいな時に便利で強力 (Userクラスのinitializeメソッドで引数にハッシュを設定)  
    一般に「マスアサインメント（mass assignment）」と呼ばれる

- 「'p :name' = 'puts :name.inspect'」  
    オブジェクトを表示するために inspect がある。省略は p

- 「実は、Ruby では丸カッコは使用してもしなくても構いません」  
    実は。

- 「実は、ハッシュがメソッド呼び出しの最後の引数である場合は、波カッコを省略できます」  
    実は。

- 「実は、Rubyは改行と空白を区別していません」  
    実は。

- 「Hashのコンストラクタはハッシュのデフォルト値を引数にとる」  
    Arrayみたいに初期値ではない

- 「大いなる力には大いなる責任が伴う」
    > 組み込みクラスの変更はきわめて強力なテクニックですが、大いなる力には大いなる責任が伴います。
    > このため、真に正当な理由がない限り、組み込みクラスにメソッドを追加することは無作法であると
    > 考えられています

- 「Railsは確かにRubyで書かれているが、既にRubyとは別物である」

## レビュー

https://github.com/shmn7iii/rails_tutorial/pull/5

### コメント

> 一部は”学び”セクションに追記

- 「\<a> link \</a>」  
    rails だし link_to を使った方がいい
    -> この先の章で出てきた

