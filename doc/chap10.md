#  第10章

## 学び

- 「ブラウザはそのままではPATCHリクエストを理解できない」  
    のでRailsはPOSTで偽装してる  
    新規作成のPOSTと更新のPOSTの見分けはActive Recordのnew_record?論理値メソッドを使って区別

- 「サンプルがいっぱい欲しい」  
    FakerというGemを使うと便利。内容は `db/seed.rb` に保存される。実行は `rails db:seed`

- 「ひとページに100人表示されても困る、30人くらいがいい」  
    みたいなやつは「ページネーション（pagination）」と呼ぶ

- 「」
  ↓これを
  ```html
  <ul class="users">
    <% @users.each do |user| %>
      <%= render user %>
    <% end %>
  </ul>
  ```
  ↓こうしても
  ```html
  <%= render @users %>
  ```
  Railsは `@users` をUserのリストと解釈して自動でコレクションを列挙してパーシャルに通してくれる

- 「toggle!」
    ```ruby
    user.toggle!(:admin)
    ```
    とすると、 `admin` 属性の状態が反転する  
    false->true / true->false

- 「管理者だけがユーザー削除ボタンが見えるようにすれば安心？」  
    直接deleteリクエストを送られる可能性がある  
    ので、before_actionでadminでログインしてるかを確認しよう
    ```ruby
    before_action :admin_user,     only: :destroy
    ...
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    ```

- 「Herokuの本番環境のデータベースをリセットしたい」  
    `pg:reset`タスクを使いましょう
    ```bash
    $ heroku pg:reset DATABASE
    $ heroku run rails db:migrate
    $ heroku run rails db:seed
    ```
