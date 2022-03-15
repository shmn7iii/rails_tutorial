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
    ```
