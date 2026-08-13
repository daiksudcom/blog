---
type: "Architecture Decision Record"
title: "ADR 0005: 記事とタグのルーティング"
description: "記事slugとtagをBlog origin直下の共有namespaceへ配置し、Content manifestで衝突を検証することを定める。"
resource: "https://github.com/daiksudme/blog/blob/main/docs/adr/0005-article-and-tag-routing.md"
tags: [blog, adr, architecture, article-routing, tag-routing]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-13T00:35:00Z
---

# ADR 0005: 記事とタグのルーティング

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

短く恒久的な記事 URL と、タグによる発見 URL を同じ Blog origin で提供する必要がある。

## 決定

記事とタグ一覧を Blog の公開 origin 直下に配置し、同一 namespace を共有する。Content manifest を routing source of truth とし、Blog は manifest entry の種別に従って記事またはタグ一覧を解決する。公開名、予約 route、衝突時の割り当ては Content の route 契約に従い、具体的な公開 URL は[記事ページ仕様](../features/article-page.feature)と[タグ一覧仕様](../features/tag-list.feature)を正本とする。

## 検討した選択肢

- 日付を含む記事 URL
- `/posts/` と `/tags/` で分離した namespace
- origin 直下の共有 namespace と build-time validation

## 結果

公開 URL は短くなる。新しい記事やタグは manifest 検証を通過した一意の route としてのみ公開され、SSR は manifest の種別に基づいて記事またはタグページを解決する。

## 関連文書

- [記事ページ仕様](../features/article-page.feature)
- [タグ一覧仕様](../features/tag-list.feature)
- [Content slug 仕様](https://github.com/daiksudme/content/blob/main/docs/features/slug-and-tag.feature)
