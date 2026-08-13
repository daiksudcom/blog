---
type: "Architecture Decision Record"
title: "ADR 0004: Cloudflare native ISR"
description: "Cloudflare native Workers CachingをISR配信層に採用し、SWR、stale-if-error、resource tag purgeを定める。"
resource: "https://github.com/daiksudme/blog/blob/main/docs/adr/0004-cloudflare-native-isr.md"
tags: [blog, adr, architecture, cloudflare-native-isr]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-13T00:35:00Z
---

# ADR 0004: Cloudflare native ISR

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

Blog は edge cache の速度を保ちながら、Content release 後に記事由来ページを再生成し、Content の一時障害にも耐える必要がある。

## 決定

production Wrangler 設定で cache を有効にし、Cloudflare native Workers Caching を ISR 相当の配信層にする。browser と edge の freshness policy を分離し、stale-while-revalidate と stale-if-error を利用する。cache key は Worker のデプロイバージョンと、応答へ影響する評価済みflag variationで分離する。Content に依存する応答は resource-scoped cache tag によって Content release 時に無効化する。flagに依存する応答はflag variationがcache keyに含まれるため、flags repository側の状態変更でcacheを共有しない。現在の cache policy、tag、再生成結果は [Blog ISR 仕様](../features/blog-isr.feature)を正本とする。

## 検討した選択肢

- 各要求を常に SSR する構成
- Astro の実験的 cache API
- Cloudflare native cache と resource-scoped purge

## 結果

通常時は edge から低遅延で配信し、再検証中または Content の一時障害時にも利用可能な応答を維持できる。flag公開前の応答が公開後に混入せず、flagをOFFへ戻した後も公開中のcacheを再利用しない。代わりに、Cloudflare の cache semantics、Content release と Deploy の tag 協調、cache状態の運用観測が必要になる。

## 関連文書

- [Blog ISR 仕様](../features/blog-isr.feature)
- [Content cache 仕様](https://github.com/daiksudme/content/blob/main/docs/features/content-cache.feature)
