@blog @tag @infinite-scroll
Feature: タグで絞った記事一覧を閲覧する
  読者として
  関心のある主題の記事だけを探すために
  タグ URL で絞り込んだ一覧を継続的に読み込みたい

  Rule: タグ一覧は記事一覧と同じ継続読込の振る舞いを使う

    Scenario: 既知のタグを開く
      Given "astro" タグに公開済み記事が18件ある
      When 読者が "https://blog.daiksud.com/astro/" を開く
      Then "astro" タグの最初の12件が SSR された HTML に含まれる
      And ページの見出しは "astro" の記事一覧を示す
      And canonical URL は "https://blog.daiksud.com/astro/" である

    Scenario: タグ一覧の続きを読み込む
      Given "astro" の一覧に12件が表示され、その続きに同じタグの公開済み記事がある
      When 自動読込または「さらに読み込む」ボタンが作動する
      Then 同じタグの次の記事を最大12件、公開日時の順序どおりに追記する
      And 他のタグだけを持つ記事や既存記事を追加しない

    Scenario: 未知のタグを開く
      Given "unknown-topic" タグを持つ公開済み記事は存在しない
      When 読者が "https://blog.daiksud.com/unknown-topic/" を開く
      Then HTTP ステータス 404 のページを受け取る
