@blog @article @seo
Feature: 記事ページを読む
  読者として
  記事の本文と位置付けを理解するために
  Content が生成した記事と補助情報を一つの公開 URL で読みたい

  Rule: 記事は slug を blog origin 直下に配置する

    Scenario: 公開済み記事を表示する
      Given Content API に slug "cloudflare-isr" の記事がある
      When 読者が "https://blog.daiksud.com/cloudflare-isr/" を開く
      Then format "trusted-html" の本文が SSR される
      And cover と代替テキスト、公開日、更新日、tags を表示する
      And 見出し目次と日本語の読了時間を表示する
      And 前の記事と次の記事へのリンクを利用できる
      And canonical URL は要求した公開 URL である

    Scenario: 更新日のない記事を表示する
      Given 記事には公開日があり更新日はない
      When 記事ページを SSR する
      Then 公開日を表示する
      And 構造化メタデータの datePublished に公開日を設定する

    Scenario: 未知の slug を開く
      Given "missing-article" は Content manifest に存在しない
      When 読者が "https://blog.daiksud.com/missing-article/" を開く
      Then HTTP ステータス 404 のページを受け取る
