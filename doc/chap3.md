# 第3章

## 学び
- 「.keepファイルについて」  
    rails new 時に –skip-keeps オプション追加で生成されないようにできる  
    cf. https://railsdoc.com/page/rails_new

- 「railsコマンド短縮形」  
    | 完全なコマンド      | 短縮形     |
    | ----              | ----      |
    | $ rails server    | $ rails s |
    | $ rails console   | $ rails c |
    | $ rails generate  | $ rails g |
    | $ rails test      | $ rails t |
    | $ bundle install  | $ bundle  |

- 「rails generate でミスった時は rails destroy で元に戻せる」  
    dbもいじっちゃってた時は rails db:rollback でひとつ戻る  
    いっちばん最初に戻したい時は `rails db:migrate VERSION=0`

- 「テストは大事」
    > アプリケーションを開発しながらテストスイート（Test Suite） をみっちり作成しておけば、
    > いざというときのセーフティネットにもなり、それ自体がアプリケーションのソースコードの
    > 「実行可能なドキュメント」にもなります。  

    [コラムも為になる](https://railstutorial.jp/chapters/static_pages?version=6.0#aside-when_to_test)

- 「Ruby< DRY（Don’t Repeat Yourself: 繰り返すべからず）」  
    繰り返しを追放してコードをDRY（=よく乾かす）しよう

- 「erb = Embedded Ruby」  
    埋め込みRuby  
    ```text
    <% ... %>  : 処理のみ
    <%= ... %> : 出力もする
    ```
    第3章ではこれを上手く使って「なんちゃって動的ページ」を作った

- 「root_url というrailsヘルパーがある」  
    config/route.rb で root 'static_pages#home' みたいに指定すれば使える

- 「テストには setupメソッド がある」  
    各テストが実行される直前で実行されるメソッド

- 「テスト駆動開発では『 red ・ green ・ REFACTOR 』サイクルを繰り返す」  
    失敗するテスト → テストが成功するコード → リファクタリング

- 「static_pages_helper は消したらまずそう」  
    消したらテスト失敗するようになった  
    [該当commit](https://github.com/shmn7iii/rails_tutorial/commit/636fe953db6503633dae8eee7a01560da272c133)

- 「minitest-reporter、めっちゃ見やすい」  
    [該当commit](https://github.com/shmn7iii/rails_tutorial/commit/f631b021e09d76cf9a62b303fc1b7f94026aa7bc)

- 「Guard、便利」  
    テストが謎に失敗する時はSpringを再起動するといい `bin/spring stop`  
    [該当commit](https://github.com/shmn7iii/rails_tutorial/commit/31a703e003c99a0cc38d10b57e0acf53b93cdd54)

## レビュー

第4章と同時

https://github.com/shmn7iii/rails_tutorial/pull/5
