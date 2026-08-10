# language: ja
@blog @seo @feed
機能: 記事をフィードと検索エンジンへ公開する
  読者と crawler として
  正規の Blog URL から記事を発見するために
  RSS、sitemap、robots、メタデータを利用したい

  シナリオ: RSS フィードを取得する
    もしclient が "https://blog.daiksud.com/rss.xml" を取得する
    ならば公開日時降順の記事 item を含む有効な RSS を受け取る
    かつchannel link と各 item link は "https://blog.daiksud.com" origin を使う
    かつ各 item guid は恒久的な記事 URL である

  シナリオ: sitemap から公開ページを発見する
    もしcrawler が "https://blog.daiksud.com/sitemap.xml" を取得する
    ならば記事ページと既知のタグページの canonical URL を発見できる

  シナリオ: robots 方針を取得する
    もしcrawler が "https://blog.daiksud.com/robots.txt" を取得する
    ならばBlog の公開ページを crawl できる
    かつsitemap の絶対 URL を発見できる

  シナリオ: 記事の共有メタデータを得る
    前提公開済み記事ページがある
    もしcrawler が記事ページを取得する
    ならばcanonical と Open Graph URL は同じ "https://blog.daiksud.com/{slug}/" である
    かつtitle、description、cover の Open Graph 情報を得る

  シナリオ: 公開ページの利用を計測する
    もし読者が production の Blog ページを表示する
    ならばCloudflare Web Analytics が privacy-preserving な page view を記録する
