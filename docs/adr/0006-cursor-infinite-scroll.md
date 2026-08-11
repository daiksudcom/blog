---
type: "Architecture Decision Record"
title: "ADR 0006: cursor 無限スクロール"
description: "cursor paginationとprogressive enhancementを採用し、自動triggerと明示buttonを一つの読込制御へ統合することを定める。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/0006-cursor-infinite-scroll.md"
tags: [blog, adr, architecture, cursor, infinite-scroll]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-11T21:36:04Z
---

# ADR 0006: cursor 無限スクロール

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

記事数が増えても公開日時順を安定して継続取得でき、マウス、touch、キーボードのいずれでも操作できる一覧が必要である。

## 決定

最初の一覧を SSR し、続きは Content API の opaque cursor で取得する。`IntersectionObserver` による自動トリガーと「さらに読み込む」ボタンを同じ読込制御へ接続する。読込制御は idle、loading、error、complete を管理し、重複排除と cursor の単一進行を保証する。現在の取得件数、読者への通知、終端、再試行結果は[記事一覧仕様](../features/article-list.feature)と[タグ一覧仕様](../features/tag-list.feature)を正本とする。

## 検討した選択肢

- offset pagination
- URL page 単位の一覧
- cursor と段階的に強化した無限スクロール

## 結果

追加中の公開でも cursor 契約に基づく安定した続きが得られ、自動操作と明示操作で異なる読込経路を持たずに済む。代わりに、成功するまで cursor を進めない制御と、client 側での重複排除が必要になる。

## 関連文書

- [記事一覧仕様](../features/article-list.feature)
- [タグ一覧仕様](../features/tag-list.feature)
