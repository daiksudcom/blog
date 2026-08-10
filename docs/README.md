---
type: "Documentation Index"
title: "文書"
description: "Blogの受け入れ基準となる振る舞い仕様と技術判断への入口を提供する。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/README.md"
tags: [blog, documentation, index]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-10T07:12:38Z
---

# 文書

このディレクトリは `blog.daiksud.com` の受け入れ基準と技術判断を管理します。

- [振る舞い仕様](features/README.md): 公開サイトから観測できる振る舞いを、キーワードを英語、シナリオ本文を日本語とする Gherkin で定義します。
- [Architecture Decision Records](adr/README.md): 実装を拘束する設計判断と結果を記録します。

Blog は [Content](https://github.com/daiksudcom/content) が提供する記事契約と [UI](https://github.com/daiksudcom/ui) の選択済みバージョンを利用し、独立してビルド、検証、デプロイします。
