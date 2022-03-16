#  第14章

## 学び

- 「複合キーインデックス」  
    follower_idとfollowed_idの組み合わせが必ずユニークであることを保証したい
    ```ruby
    add_index :relationships, [:follower_id, :followed_id], unique: true
    ```

- 「またエラーが止まらなくなった」  
    users_controller.rbの%i記法消したら通った  
    チュートリアルでやってるテストとの相性が悪いのかな…

- 「Relationship」  
    ややこしいこの設定の効力は…  
    ```ruby
    class User < ApplicationRecord
      has_many :active_relationships, class_name:  "Relationship",
                                      foreign_key: "follower_id",
                                      dependent:   :destroy
      has_many :following, through: :active_relationships, source: :followed
      ...
    end
    ```
    こんなことができるようになること  
    ```ruby
    user.following.include?(other_user)
    user.following.find(other_user)
    user.following << other_user
    user.following.delete(other_user)
    ```
    外部キーの設定やfollowedをfollowingという名前に書き換えたりしたりしてる

- 「route.rb」  
    ```ruby
    resources :users do
      member do
        get :following, :followers
      end
    end
    ```
    /users/1/following や /users/1/followers が生成される

- 「form_with」  
    ```ruby
    <%= form_with(model: current_user.active_relationships.build, local: false) do |f| %>
      <div><%= hidden_field_tag :followed_id, @user.id %></div>
      <%= f.submit "Follow", class: "btn btn-primary" %>
    <% end %>
    ```
    モデルオブジェクトをerbから操作できる

- 「Ajax」  
    > Ajaxを使えば、Webページからサーバーに「非同期」で、ページを移動することなくリクエストを送信することができます 。WebフォームにAjaxを採用するのは今や当たり前になりつつあるので、RailsでもAjaxを簡単に実装できるようになっています。

    > 次のコードがあるとすると、
    ```ruby
    form_with(model: ..., local: true)
    ```
    > 次のように置き換えるだけです。
    ```ruby
    form_with(model: ..., local: false)
    ```
    > たったこれだけで、Railsは自動的にAjaxを使うようになります

    今回は「フォローボタン押した後のリダイレクトは本当に必要ですか？」問題を解決するために
    非同期処理を導入する目的でAjaxを利用  
    ページを移動することなくリクエストの送信が可能になる

    これらAjaxの処理ができるようにコントローラー側では
    ```ruby
    respond_to do |format|
      format.html { redirect_to user }
      format.js
    end
    ```
    のような記述を追加する  
    htmlでやってきたらリダイレクトして〜のような、条件処理のイメージ

    テストでAjaxを利用した送信をするには `xhr: true` を追加する

- 「mapの便利技」  
    ```ruby
    [1, 2, 3, 4].map { |i| i.to_s }
    # => ["1", "2", "3", "4"]

    # 省略記法
    [1, 2, 3, 4].map(&:to_s)
    # => ["1", "2", "3", "4"]

    # join
    [1, 2, 3, 4].map(&:to_s).join(', ')
    # => "1, 2, 3, 4"

    # ---

    # user.following の id を列挙したい
    User.first.following.map(&:id)
    # ActiveRecord では以下を用意してくれる
    User.first.following_ids

    # ただ実際に使うときにはこれでいい
    Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)

    # 効率化するとこう
    # SQLのサブセレクトを使った例
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids}) 
                     OR user_id = :user_id", user_id: id)

    # レビューより、さらに簡単にも書ける
    following_ids = "user_id IN (SELECT followed_id FROM relationships
                                 WHERE follower_id = #{id})"
    Micropost.where(following_ids).or(Micropost.where(user_id: id))
    ```


## レビュー

### コメント

- 「%記法の場合コンマは不要」  
    ```ruby
    %i[create destroy]
    ```
    スペース区切り。おそらくいつからか自分が取り違えてました…


- 「map と each」
    ```ruby
    [1, 2, 3, 4].map { |i| i.to_s }
    # => ["1", "2", "3", "4"]

    [1, 2, 3, 4].each { |i| i.to_s }
    # => [1, 2, 3, 4]
    ```
    `map` では要素すべてにto_sしてくれた。  
    `each` ではそうはしてくれなかった。

    これは  
    「`map` はブロック内で行なった処理結果を元の配列にも適用させる、結果を保持してくれる」  
    「`each` は単に繰り返し処理をブロック内で行い、元の配列は元のまま」  
    であることから。


### FYI

- 「より簡単なwhere」  
    5系から追加された以下の記法もある  
    cd. https://style.potepan.com/articles/29804.html
    ```ruby
    Micropost.where(user_id: following_ids).or(Micropost.where(user_id: id))
    ```
    今回のアプリに適用させる場合、以下でエラーなく通った
    ```ruby
    following_ids = "user_id IN (SELECT followed_id FROM relationships
                                 WHERE follower_id = #{id})"
    Micropost.where(following_ids).or(Micropost.where(user_id: id))
    ```

- 「不要なバリデーション」  
    ```ruby
    belongs_to       :user
    has_one_attached :image
    default_scope -> { order(created_at: :desc) }
    validates :user_id, presence: true
    ```
    > belongs_toでアソシエーションを定義しているのでこのバリデーションは不要です。  
    > ちなみに nil を許容したい場合optional: trueを付与します。  
    > https://techtechmedia.com/optional-true-rails/  

    `validates` で「`user_id` の `presence` は `true` にしてね」と指定したが、
    その後 `belongs_to` で `user` を指定している（アソシエーションを組んでいる）ので不要になった。

    チュートリアルでは
    ```ruby
    test "user id should be present" do
      @micropost.user_id = nil
      assert_not @micropost.valid?
    end
    ```
    userr_idが存在するか確かめるテストを書く前提で、
    `validates :user_id, presence: true`
    を定義しており、
    ```ruby
    # このコードは慣習的に正しくない
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
    ```
    を使ってマイクロポストを生成する場合では `validates` は不要だが
    ```ruby
    # 慣習的に正しい
    @micropost = @user.microposts.build(content: "Lorem ipsum")
    ```
    とする場合に必要であると説明している。


    なので、今回の例で `validates` を削除するなら
    ```diff
    - @micropost = @user.microposts.build(content: "Lorem ipsum")
    + @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
    ```
    とする必要がある。そうすればテストも無事通る。（コミットはチュートリアル通りです）

- 「Ajaxでも出てきた `form_with` の `local`」  
    > Rails 6.1からlocal: trueを明示的に指定する必要がなくなっています。  
    > https://bon-voyage23.hatenablog.com/entry/2021/05/01/152200

    普段は省略して書いて、Ajax使うときに明示的にfalseとすればOK。
