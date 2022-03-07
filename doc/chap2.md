
# 第2章

## 学び

- 「scaffoldコード」  
    サクッと作るならでら便利だけどややこしいし読みづらい

- 「:userみたいなやつ」  
    "シンボル"と呼ばれる

- 「ユーザーがmicropostをたくさん持つよ」  
    has_many :microposts | app/models/user.rb

- 「micropostは一人のユーザーに属するよ」  
    belongs_to :user | app/models/micropost.rb

## レビュー
https://github.com/shmn7iii/rails_tutorial/pull/2


### コメント

- 「不要ファイルは消していい」  
    app/assets/stylesheets/users.scss, microposts.scss  
    app/helpers/users_helper.rb, microposts_helper.rb

- 「シンボルの配列は%記法を用いることが多い」  
    ```ruby
    before_action :set_micropost, only: [:show, :edit, :update, :destroy]
    よりも
    before_action :set_micropost, only: %i[show, edit, update, destroy]
    ```

- 「privateメソッドの中身はインデント揃えるのが一般的」  
    ```ruby
    private
    def set_user
      @user = User.find(params[:id])
    end
    ```

### FYI

- 「実際のサービスでは null: false などバリデーションを指定することが多い」  
    ここ：db/migrate/20220303055523_create_users.rb  
    チュートリアル内でもここについて指摘あったのでこの先の章で説明出てくるかも

- 「実際のサービスでは t.references :user などと書くことが多い」  
    ここ：db/migrate/20220303061143_create_microposts.rb  
    cf. https://qiita.com/ryouzi/items/2682e7e8a86fd2b1ae47  
    メリット：  
    ・userではなくuser_idというカラム名を作成してくれる  
    ・インデックスを自動で張ってくれる  

### 見反映FYI

- 「デフォルトのテンプレートエンジンは erb よりスッキリな slim がよく使われる」  
    cf. https://qiita.com/ngron/items/c03e68642c2ab77e7283」  
    今回のチュートリアルはerbのまま進める  
    HTML苦手マン的にはめちゃくちゃ嬉しいslim
