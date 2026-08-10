# language: ja
@blog @isr @cloudflare @cache
機能: Blog ページを Cloudflare キャッシュから再生成する
  運用者として
  低い応答時間と新しい Content を両立するために
  native Workers Caching を ISR として運用したい

  背景:
    前提production Worker で cache.enabled が true である
    かつBlog 由来の応答には cache tag "content-blog-current" が付く
    かつbrowser TTL は0秒、edge TTLは300秒、SWRは3600秒、stale-if-errorは86400秒である

  シナリオ: キャッシュミスを SSR して保存する
    前提バージョン固有の cache key に応答がない
    もし読者が Blog ページを要求する
    ならばWorker は Content を取得して SSR する
    かつ応答を Cloudflare キャッシュへ保存する
    かつCF-Cache-Status で MISS を観測できる

  シナリオ: 有効なキャッシュを返す
    前提同じバージョン固有 key に有効な応答がある
    もし読者が同じページを要求する
    ならばCloudflare は Worker の SSR 処理を迂回して応答する
    かつCF-Cache-Status で HIT を観測できる

  シナリオ: 期限切れ応答をバックグラウンド更新する
    前提edge TTLを過ぎSWR期間内の応答がある
    もし読者がページを要求する
    ならばstale 応答を直ちに返す
    かつバックグラウンドで Content を取得して応答を再生成する

  シナリオ: Content 障害時に stale 応答を返す
    前提86400秒以内の stale 応答がある
    かつ再生成時の Content 取得が失敗する
    もし読者がページを要求する
    ならば利用可能な stale 応答を返す

  シナリオ: Content リリース後に再生成する
    前提Content release が "content-blog-current" を purge した
    もし読者が Blog ページを要求する
    ならば現在の Content revision で SSR した応答を保存する
