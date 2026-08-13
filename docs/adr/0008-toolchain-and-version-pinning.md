---
type: "Architecture Decision Record"
title: "ADR 0008: ツールチェーンとバージョン固定"
description: "Blogのtoolchainと共有packageをrepository単位の厳密なversionへ固定することを定める。"
resource: "https://github.com/daiksudme/blog/blob/main/docs/adr/0008-toolchain-and-version-pinning.md"
tags: [blog, adr, architecture, toolchain, version-pinning]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-13T00:35:00Z
---

# ADR 0008: ツールチェーンとバージョン固定

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

Blog を単独でビルド、検証、Cloudflare Workers へデプロイし、同じ入力から同じ成果物を再現する必要がある。

## 決定

Node.js 24.16.0 以上、pnpm 11、Astro 7.2.0 を標準とし、開発・検証コマンドは pnpm から各ツールを直接実行する。pnpm 自体は `11.21.0`、Wranglerは`4.107.0`を宣言する。すべての依存は version range を使わずマニフェストと lockfile に正確に固定し、CI は frozen lockfile で取得する。将来導入する`@astrojs/cloudflare`、ほかのbuild dependency、`@daiksudme/ui`も採用したexact versionに固定する。Contentとの契約はpackageではなく、ADR 0003で定めたOpenAPI SemVerへ固定する。実行コードは Web 標準 API を基準とする。

整形と静的検査の責務は、Biome を JavaScript、TypeScript、JSON、CSS、Prettier を Astro と YAML、rumdl を Markdown と MDX、ESLint を型情報が必要な TypeScript と Astro、Stylelint を CSS と Astro、knip を未使用の依存、export、file に割り当てる。Astro の型・コンテンツ検査は `astro check` が担う。

## 検討した選択肢

- version range で自動更新する構成
- repository 全体で一つの依存バージョンを共有する構成
- Vite+ を開発コマンドの統合入口として使う構成
- repository ごとに完全な toolchain と依存を固定する構成

## 結果

Blog だけを変更した pull request は Blog だけをビルドでき、Home の build を要求しない。ローカルと CI は同じ pnpm scripts を実行し、依存更新はマニフェストと lockfile の意図した差分としてレビューされる。

## 関連文書

- [ADR 0001](0001-repository-boundary.md)
- [ADR 0002](0002-astro-cloudflare-ssr.md)
- [Content](https://github.com/daiksudme/content)
- [UI](https://github.com/daiksudme/ui)
