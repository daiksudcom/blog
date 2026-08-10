# language: ja
@blog @article @seo
機能: 記事ページを読む
  読者として
  記事の本文と位置付けを理解するために
  Content が生成した記事と補助情報を一つの公開 URL で読みたい

  ルール: 記事は slug を blog origin 直下に配置する

    シナリオ: 公開済み記事を表示する
      前提Content API に slug "cloudflare-isr" の記事がある
      もし読者が "https://blog.daiksud.com/cloudflare-isr/" を開く
      ならばformat "trusted-html" の本文が SSR される
      かつcover と代替テキスト、公開日、更新日、tags を表示する
      かつ見出し目次と日本語の読了時間を表示する
      かつ前の記事と次の記事へのリンクを利用できる
      かつcanonical URL は要求した公開 URL である

    シナリオ: 更新日のない記事を表示する
      前提記事には公開日があり更新日はない
      もし記事ページを SSR する
      ならば公開日を表示する
      かつ構造化メタデータの datePublished に公開日を設定する

    シナリオ: 未知の slug を開く
      前提"missing-article" は Content manifest に存在しない
      もし読者が "https://blog.daiksud.com/missing-article/" を開く
      ならばHTTP ステータス 404 のページを受け取る
