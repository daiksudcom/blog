# ADR 0004: Cloudflare native ISR

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

Blog は edge cache の速度を保ちながら、Content release 後に記事由来ページを再生成し、Content の一時障害にも耐える必要がある。

## 決定

production Wrangler 設定で `cache.enabled=true` とし、Cloudflare native Workers Caching を ISR 相当の配信層にする。ブラウザーには `Cache-Control: public, max-age=0`、Cloudflare には `Cloudflare-CDN-Cache-Control: public, max-age=300, stale-while-revalidate=3600, stale-if-error=86400` を返す。Blog 由来の応答へ `content-blog-current` を付け、複合ページには全 resource tag を付ける。Worker のバージョン固有 cache key を用い、Content release が該当 tag を purge する。

## 検討した選択肢

- 各要求を常に SSR する構成
- Astro の実験的 cache API
- Cloudflare native cache と resource-scoped purge

## 結果

MISS は SSR して保存され、HIT は Worker 処理を迂回する。300秒後は最大3600秒 stale を返しながら更新し、更新障害時は最大86400秒 stale を利用する。`CF-Cache-Status` を運用観測に使う。

## 関連文書

- [Blog ISR 仕様](../features/blog-isr.feature)
- [Content cache 仕様](https://github.com/daiksudcom/content/blob/main/docs/features/content-cache.feature)
