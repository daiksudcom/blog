---
type: "Architecture Decision Record"
title: "ADR 0008: ツールチェーンとバージョン固定"
description: "Blogのtoolchainと共有packageをrepository単位の厳密なversionへ固定することを定める。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/0008-toolchain-and-version-pinning.md"
tags: [blog, adr, architecture, toolchain, version-pinning]
timestamp: 2026-08-10T06:56:15Z
---

# ADR 0008: ツールチェーンとバージョン固定

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

Blog を単独でビルド、検証、Cloudflare Workers へデプロイし、同じ入力から同じ成果物を再現する必要がある。

## 決定

Node.js 24、pnpm 11、Astro 7、Vite+ を標準とする。Wrangler は `4.107.0` 以上から採用した一つのパッチ版、`@astrojs/cloudflare` と他の build dependency も採用パッチ版をマニフェストと lockfile に正確に固定する。`@daiksudcom/content` と `@daiksudcom/ui` は厳密な SemVer を指定する。実行コードは Web 標準 API を基準とする。

## 検討した選択肢

- version range で自動更新する構成
- repository 全体で一つの依存バージョンを共有する構成
- repository ごとに完全な toolchain と依存を固定する構成

## 結果

Blog だけを変更した pull request は Blog だけをビルドでき、Home の build を要求しない。依存更新は意図した差分としてレビューされる。

## 関連文書

- [Blog ISR 仕様](../features/blog-isr.feature)
- [Content](https://github.com/daiksudcom/content)
- [UI](https://github.com/daiksudcom/ui)
