@blog @seo @feed
Feature: 記事をフィードと検索エンジンへ公開する
  読者と crawler として
  正規の Blog URL から記事を発見するために
  RSS、sitemap、robots、メタデータを利用したい

  Scenario: RSS フィードを取得する
    When client が "https://blog.daiksud.com/rss.xml" を取得する
    Then 公開日時降順の記事 item を含む有効な RSS を受け取る
    And channel link と各 item link は "https://blog.daiksud.com" origin を使う
    And 各 item guid は恒久的な記事 URL である

  Scenario: sitemap から公開ページを発見する
    When crawler が "https://blog.daiksud.com/sitemap.xml" を取得する
    Then 記事ページと既知のタグページの canonical URL を発見できる

  Scenario: robots 方針を取得する
    When crawler が "https://blog.daiksud.com/robots.txt" を取得する
    Then Blog の公開ページを crawl できる
    And sitemap の絶対 URL を発見できる

  Scenario: 記事の共有メタデータを得る
    Given 公開済み記事ページがある
    When crawler が記事ページを取得する
    Then canonical と Open Graph URL は同じ "https://blog.daiksud.com/{slug}/" である
    And title、description、cover の Open Graph 情報を得る

  Scenario: 公開ページの利用を計測する
    When 読者が production の Blog ページを表示する
    Then Cloudflare Web Analytics が privacy-preserving な page view を記録する
