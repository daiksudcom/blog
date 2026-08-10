---
type: "Architecture Decision Record"
title: "ADR 0002: Astro と Cloudflare による SSR"
description: "Astro 7とCloudflare adapterを採用し、Contentから取得した記事をCloudflare WorkersでSSRすることを定める。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/0002-astro-cloudflare-ssr.md"
tags: [blog, adr, architecture, astro, cloudflare, ssr]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-10T07:07:01Z
---

# ADR 0002: Astro と Cloudflare による SSR

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

記事一覧、タグ一覧、記事ページは Content の現在 revision を使って HTML を生成し、Cloudflare edge で配信する必要がある。

## 決定

Astro 7、Astro コンポーネント、`@astrojs/cloudflare`、`output: server` を採用し、Cloudflare Workers で SSR する。MDX を扱う箇所は使用する Astro コンポーネントを明示的に import する。Worker のランタイム契約は Web 標準 API とする。

## 検討した選択肢

- 全ページを静的生成する構成
- Cloudflare adapter を使う Astro SSR
- browser UI framework を含む SSR

## 結果

Astro の Request/Response と Cloudflare binding を同じサーバー境界で扱える。SSR 応答は native Workers Caching の対象になる。

## 関連文書

- [記事ページ仕様](../features/article-page.feature)
- [ADR 0004](0004-cloudflare-native-isr.md)
