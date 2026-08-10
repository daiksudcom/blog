---
type: "Architecture Decision Record"
title: "ADR 0001: Blog のリポジトリ境界"
description: "Blogが所有する表示、routing、SSR、cache、feedの責務を他のrepositoryから分離することを定める。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/0001-repository-boundary.md"
tags: [blog, adr, architecture, repository-boundary]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-10T07:07:01Z
---

# ADR 0001: Blog のリポジトリ境界

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

Blog は記事配信に特化した公開サイトであり、Home、Content、UI と異なる変更頻度とデプロイ判断を持つ。

## 決定

`blog` リポジトリは `blog.daiksud.com` の表示、ルーティング、SSR、キャッシュ、RSS、sitemap、theme、アクセシビリティを所有する。記事ソースと Content API は [Content](https://github.com/daiksudcom/content)、共有表示契約は [UI](https://github.com/daiksudcom/ui) が所有する。

## 検討した選択肢

- Home と Blog を一つのサイトとしてリリースする構成
- Content と Blog を一つの Worker としてリリースする構成
- 四つの責務を独立したリポジトリとリリース単位にする構成

## 結果

Blog だけを変更、検証、デプロイできる。依存パッケージは厳密なバージョンで選択し、他リポジトリの更新と同期を強制しない。

## 関連文書

- [振る舞い仕様](../features/README.md)
- [Home](https://github.com/daiksudcom/home)
- [Content](https://github.com/daiksudcom/content)
