#  第12章

## 学び

- 「エラーメッセージの追加」  
    `errors.add` を使ってオブジェクトにエラーを追加できる  
    ```ruby
    @user.errors.add(:password, :blank)
    ```

- 「"<" を『〜より早い時刻』と読む」  
    これは「パスワード再設定メールの送信時刻が、現在時刻より2時間以上前（早い）の場合」
    ```ruby
    # パスワード再設定の期限が切れている場合はtrueを返す
    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end
    ```
