@blog @tag @infinite-scroll
Feature: タグで絞った記事一覧を閲覧する
  読者として
  関心のある主題の記事だけを探すために
  タグ URL で絞り込んだ一覧を継続的に読み込みたい

  Rule: タグ一覧は記事一覧と同じ cursor 契約を使う

    Scenario: 既知のタグを開く
      Given "astro" タグに公開済み記事が18件ある
      When 読者が "https://blog.daiksud.com/astro/" を開く
      Then tag=astro で取得した最初の12件が SSR される
      And ページの見出しは "astro" の記事一覧を示す
      And canonical URL は "https://blog.daiksud.com/astro/" である

    Scenario: タグ一覧の続きを読み込む
      Given "astro" の一覧に次の opaque cursor がある
      When 自動読込または「さらに読み込む」ボタンが作動する
      Then tag=astro、limit=12、cursor を指定して要求する
      And 同じタグの次の記事だけを重複なく追記する

    Scenario: 未知のタグを開く
      Given "unknown-topic" は Content manifest に存在しない
      When 読者が "https://blog.daiksud.com/unknown-topic/" を開く
      Then HTTP ステータス 404 のページを受け取る
