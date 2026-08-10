---
type: "Architecture Decision Record"
title: "ADR 0006: cursor 無限スクロール"
description: "最初の12件をSSRし、opaque cursor、自動trigger、明示buttonで記事を継続取得することを定める。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/0006-cursor-infinite-scroll.md"
tags: [blog, adr, architecture, cursor, infinite-scroll]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-10T07:07:01Z
---

# ADR 0006: cursor 無限スクロール

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

記事数が増えても公開日時順を安定して継続取得でき、マウス、touch、キーボードのいずれでも操作できる一覧が必要である。

## 決定

最初の12件を SSR し、Content API の opaque cursor で12件ずつ追加する。`IntersectionObserver` による自動トリガーと「さらに読み込む」ボタンを同じ状態機械へ接続する。状態は idle、loading、error、complete とし、重複排除と cursor の単一進行を保証する。

## 検討した選択肢

- offset pagination
- URL page 単位の一覧
- cursor と段階的に強化した無限スクロール

## 結果

追加中の公開でも cursor 契約に基づく安定した続きが得られる。読込状態と件数は `aria-live` で通知され、失敗した cursor を明示的に再試行できる。

## 関連文書

- [記事一覧仕様](../features/article-list.feature)
- [タグ一覧仕様](../features/tag-list.feature)
