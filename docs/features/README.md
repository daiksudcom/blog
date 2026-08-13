---
type: "Gherkin Specification Index"
title: "振る舞い仕様"
description: "記事一覧、記事ページ、ISR、発見可能性、アクセシビリティ、DeployとReleaseのGherkin仕様への索引である。"
resource: "https://github.com/daiksudme/blog/blob/main/docs/features/README.md"
tags: [blog, gherkin, specification, index]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-13T00:35:00Z
---

# 振る舞い仕様

各ファイルでは Gherkin キーワードを英語、シナリオ本文を日本語で記述します。

振る舞い仕様は、読者、client、crawler、運用者から観測して検証できる現在の契約の正本です。具体的な値、URL、入出力、エラー、境界条件をここに置き、実装方式の選択理由は [ADR](../adr/README.md) に委ねます。

- [記事一覧](article-list.feature)
- [タグ一覧](tag-list.feature)
- [記事ページ](article-page.feature)
- [Blog の ISR](blog-isr.feature)
- [フィードと発見可能性](feed-and-discovery.feature)
- [テーマとアクセシビリティ](theme-and-accessibility.feature)
- [DeployとProduct Release](delivery-and-release.feature)

各ファイルは一つの観測可能な能力を扱い、`@blog` と能力別タグで分類します。
