# language: ja
@blog @tag @infinite-scroll
機能: タグで絞った記事一覧を閲覧する
  読者として
  関心のある主題の記事だけを探すために
  タグ URL で絞り込んだ一覧を継続的に読み込みたい

  ルール: タグ一覧は記事一覧と同じ cursor 契約を使う

    シナリオ: 既知のタグを開く
      前提"astro" タグに公開済み記事が18件ある
      もし読者が "https://blog.daiksud.com/astro/" を開く
      ならばtag=astro で取得した最初の12件が SSR される
      かつページの見出しは "astro" の記事一覧を示す
      かつcanonical URL は "https://blog.daiksud.com/astro/" である

    シナリオ: タグ一覧の続きを読み込む
      前提"astro" の一覧に次の opaque cursor がある
      もし自動読込または「さらに読み込む」ボタンが作動する
      ならばtag=astro、limit=12、cursor を指定して要求する
      かつ同じタグの次の記事だけを重複なく追記する

    シナリオ: 未知のタグを開く
      前提"unknown-topic" は Content manifest に存在しない
      もし読者が "https://blog.daiksud.com/unknown-topic/" を開く
      ならばHTTP ステータス 404 のページを受け取る
