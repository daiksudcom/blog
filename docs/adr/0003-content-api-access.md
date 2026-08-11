---
type: "Architecture Decision Record"
title: "ADR 0003: Content API へのアクセス"
description: "共通Content clientと交換可能なtransportを採用し、SSRとbrowser追加取得で同じschemaを使うことを定める。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/0003-content-api-access.md"
tags: [blog, adr, architecture, content-api-access]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-11T21:36:04Z
---

# ADR 0003: Content API へのアクセス

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

SSR、preview、ローカル開発、ブラウザーの追加読込は異なる通信経路を持つが、同じ Content schema とエラー契約を利用する必要がある。

## 決定

`@daiksudcom/content` の `createContentClient({ transport })` を使用する。本番 SSR は Cloudflare Service Binding transport、preview とローカルは HTTPS transport、ブラウザーの無限スクロールは `https://content.daiksud.com/v1/blog` への HTTPS transport を使う。クライアントは Zod で応答を検証する。

## 検討した選択肢

- 各画面が独自に fetch と schema を実装する構成
- すべての環境で public HTTPS を使う構成
- 共通 client と交換可能な transport を使う構成

## 結果

本番 SSR は Cloudflare 内の低遅延な経路を利用でき、preview とブラウザーは同じ型付き契約を HTTPS で利用できる。schema 不整合は表示前に検出される。

## 関連文書

- [記事一覧仕様](../features/article-list.feature)
- [タグ一覧仕様](../features/tag-list.feature)
- [記事ページ仕様](../features/article-page.feature)
- [Content client 仕様](https://github.com/daiksudcom/content/blob/main/docs/features/content-package.feature)
