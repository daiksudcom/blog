---
type: "Architecture Decision Record"
title: "ADR 0005: 記事とタグのルーティング"
description: "記事slugとtagをBlog origin直下の共有namespaceへ配置し、Content manifestで衝突を検証することを定める。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/0005-article-and-tag-routing.md"
tags: [blog, adr, architecture, article-routing, tag-routing]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-10T07:07:01Z
---

# ADR 0005: 記事とタグのルーティング

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

短く恒久的な記事 URL と、タグによる発見 URL を同じ Blog origin で提供する必要がある。

## 決定

記事を `https://blog.daiksud.com/{article-name}/`、タグ一覧を `https://blog.daiksud.com/{tag}/` に配置する。両者は同一 namespace を共有する。Content manifest を routing source of truth とし、lowercase ASCII kebab の名前、予約 route、記事とタグの衝突を公開前に検証する。同じ article-name では最古の記事が基本 slug を保持し、後の記事へ `-YYYYMMDD` を付ける。

## 検討した選択肢

- 日付を含む記事 URL
- `/posts/` と `/tags/` で分離した namespace
- origin 直下の共有 namespace と build-time validation

## 結果

公開 URL は短くなる。新しい記事やタグは manifest 検証を通過した一意の route としてのみ公開され、SSR は manifest の種別に基づいて記事またはタグページを解決する。

## 関連文書

- [記事ページ仕様](../features/article-page.feature)
- [タグ一覧仕様](../features/tag-list.feature)
- [Content slug 仕様](https://github.com/daiksudcom/content/blob/main/docs/features/slug-and-tag.feature)
