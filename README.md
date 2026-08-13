# Blog

`blog.daiksud.me` の記事一覧、タグ一覧、記事ページ、フィード、発見可能性、キャッシュの振る舞いを定義するリポジトリです。

## 現在の状態

実装開始前の基準として、観測可能な振る舞いを Gherkin、技術的な決定を Architecture Decision Records（ADR）で確定しています。Astro のアプリケーション実装に先立ち、再現可能な開発・検証用ツールチェーンを整備しています。

## 仕様書

- [文書の案内](docs/README.md)
- [振る舞い仕様](docs/features/README.md)
- [Architecture Decision Records](docs/adr/README.md)

## ローカル開発

Node.js 24.16.0 以降と pnpm 11 を使います。`.nvmrc`、`package.json` の `engines`、`packageManager` はこの組み合わせを宣言し、依存バージョンは `package.json` と `pnpm-lock.yaml` に固定しています。

```sh
pnpm install
pnpm dev
```

型検査、lint、整形確認は個別に実行できます。

```sh
pnpm check
pnpm lint
pnpm format:check
```

整形を適用するには `pnpm format`、すべての品質検査とビルドをまとめて実行するには `pnpm validate` を使います。本番用の成果物を確認する場合は、ビルド後にプレビューします。

```sh
pnpm build
pnpm preview
```

| ツール | 担当範囲 | 実行コマンド |
| --- | --- | --- |
| Astro | 型と Astro コンテンツの検査、開発、ビルド | `pnpm check`、`pnpm dev`、`pnpm build` |
| Biome | JavaScript / TypeScript / JSON / CSS の整形と lint | `pnpm lint:biome` |
| rumdl | Markdown / MDX の lint と整形 | `pnpm lint:rumdl`、`pnpm format`、`pnpm format:check` |
| Prettier | Astro / YAML の整形 | `pnpm format`、`pnpm format:check` |
| ESLint | 型情報を使う TypeScript と Astro の意味的検査 | `pnpm lint:eslint` |
| Stylelint | CSS と Astro の `<style>` ブロックの検査 | `pnpm lint:stylelint` |
| knip | 未使用の依存関係、exports、files の検出 | `pnpm lint:knip` |
| lint-staged / Husky | staged ファイルに対する整形と lint の Git hook | `pnpm lint:staged` |
| commitlint | コミット件名と pull request タイトルの検査 | `pnpm lint:commit` |

`.vscode/` には推奨拡張と formatter / lint の設定があります。ほかのエディターでも `.editorconfig` と上記コマンドを使って同じ規約を適用してください。

## コミット時の検査

`pnpm install` は Husky の Git hook を設定します。コミット前には lint-staged が staged ファイルだけを対象として、担当ツールによる整形と lint を順番に実行します。整形されたファイルは自動的に再度 stage され、lint が失敗した場合はコミットを中止します。リポジトリ全体の型検査、未使用検査、ビルドを含む最終確認には引き続き `pnpm validate` を使います。

コミット件名と pull request タイトルには Conventional Commits の `type(scope): subject` 形式を使います。scope は省略できます。

```text
feat(feed): add Atom feed endpoint
fix: preserve tag filters during navigation
docs: explain local validation
```

`commit-msg` hook はコミット件名を commitlint で検証します。CI は hook を迂回した変更も検出できるよう、pull request のタイトルと含まれる全コミット、および `main` に push されたコミットを同じ規約で検証します。通常の fast-forward push では追加コミットだけを検証し、直前の revision が all-zero、取得不能、または新しい `HEAD` の祖先でない場合は、fail-closed として新しい `HEAD` から到達可能な全履歴を検証します。GitHub 形式の two-parent pull request merge commit 本体だけは検証対象から除きます。

## 関連リポジトリ

- [Home](https://github.com/daiksudme/home)
- [Content](https://github.com/daiksudme/content)
- [UI](https://github.com/daiksudme/ui)
