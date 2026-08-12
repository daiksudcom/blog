---
type: "Architecture Decision Record Index"
title: "Architecture Decision Records"
description: "Blogの責務、SSR、Content API、ISR、routing、無限スクロール、SEO、toolchain、Git品質ゲートに関する設計判断への索引である。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/README.md"
tags: [blog, adr, architecture, index]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-12T22:52:44Z
---

# Architecture Decision Records

ADR は技術判断の背景と理由、代替案、トレードオフ、結果を記録します。現在の具体的な値、URL、入出力、エラー、境界条件は対応する[振る舞い仕様](../features/README.md)を正本とし、ADR には重複して記載しません。

| 番号 | 決定 | ステータス | 日付 |
| --- | --- | --- | --- |
| 0001 | [リポジトリ境界](0001-repository-boundary.md) | 承認済み | 2026-08-10 |
| 0002 | [Astro と Cloudflare による SSR](0002-astro-cloudflare-ssr.md) | 承認済み | 2026-08-10 |
| 0003 | [Content API へのアクセス](0003-content-api-access.md) | 承認済み | 2026-08-10 |
| 0004 | [Cloudflare native ISR](0004-cloudflare-native-isr.md) | 承認済み | 2026-08-10 |
| 0005 | [記事とタグのルーティング](0005-article-and-tag-routing.md) | 承認済み | 2026-08-10 |
| 0006 | [cursor 無限スクロール](0006-cursor-infinite-scroll.md) | 承認済み | 2026-08-10 |
| 0007 | [フィードと SEO](0007-feed-and-seo.md) | 承認済み | 2026-08-10 |
| 0008 | [ツールチェーンとバージョン固定](0008-toolchain-and-version-pinning.md) | 承認済み | 2026-08-10 |
| 0009 | [Git品質ゲート](0009-git-quality-gates.md) | 承認済み | 2026-08-13 |

まだ実装されておらず適用実績のない決定は、識別子と参照の継続性を保ったまま既存 ADR を改訂できます。実装後に変更が必要になった決定は、新しい ADR で置き換え関係を明示します。
