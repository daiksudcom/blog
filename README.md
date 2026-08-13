# Blog

`blog.daiksud.me` の記事一覧、タグ一覧、記事ページ、フィード、発見可能性、キャッシュの振る舞いを定義するリポジトリです。

## 現在の状態

実装開始前の基準として、観測可能な振る舞いを Gherkin、技術的な決定を Architecture Decision Records（ADR）で確定しています。Astro のアプリケーション実装に先立ち、再現可能な開発・検証用ツールチェーンと、安全に無効化されたDeploy pipelineを整備しています。

## 仕様書

- [文書の案内](docs/README.md)
- [振る舞い仕様](docs/features/README.md)
- [Architecture Decision Records](docs/adr/README.md)
- [GitHub、Deploy、Release の運用](.github/README.md)

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

branch名は`feat/<slug>`、`fix/<slug>`などのtype prefixを使います。breaking changeは`breaking-change/<type>/<slug>`、deprecationは`deprecated/<type>/<slug>`です。ただしversionへの影響を決めるのはbranch名ではなく**pull requestのタイトル**です。squash mergeによりタイトルがcommit件名として履歴に残るためで、branch名はlabel付けの補助にのみ使います。

## DeployとRelease

`main`へのmergeはすべてproduction Deployの対象ですが、現在は実装とCloudflare環境が未構築のため`DEPLOY_ENABLED` gateにより外部変更を行いません。Worker設定、`production` Environment、`CLOUDFLARE_DEPLOY_API_TOKEN`、account ID、Worker名、production originを準備した後にgateを有効化します。

単一のDeploy workflowが、PRタイトルに対するversion検証、tagのpush、Worker Deploy、deployment receiptの記録、GitHub Releaseの公開までを順に実行します。tag打ちを分離しないのは、`GITHUB_TOKEN`によるpushが新しいworkflow runを起動しないためです。`feat:`と`perf:`はminor、`fix:`と`revert:`はpatch、breaking changeは`0.x`の間はminorを要求し、`docs:`などversionを変えない変更にも`vX.Y.Z+YYYYMMDDHHmmss`のtagを打ちます。build識別子はmerge commitのcommitter時刻から作るため、再実行しても同じtagへ解決します。

feature flagはこのリポジトリで管理しません。flagの正本はflags repositoryにあり、Product ReleaseはそちらでflagをONにする操作として、Blogを再deployせずに完了します。minor bumpは「flagでその機能をオンオフできるcapabilityを出荷した」という宣言であり、機能自体はOFFのままです。操作契約と失敗時の振る舞いは[ADR 0010](docs/adr/0010-deploy-and-release.md)と[GitHub、Deploy、Release の運用](.github/README.md)を参照してください。

`.github/settings.yml`は`gh-infra`のadditive specです。最初にlabelsを適用し、`CI success`と`Policy success`がGitHubへ登録された後にmain rulesetを有効化します。利用中の`gh-infra`がmerge queueを管理しないため、strict required checksとauto-mergeを設定し、merge queue自体はGitHub repository settingsで有効化します。

## 関連リポジトリ

- [Home](https://github.com/daiksudme/home)
- [Content](https://github.com/daiksudme/content)
- [UI](https://github.com/daiksudme/ui)
