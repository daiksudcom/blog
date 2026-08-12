---
type: "Architecture Decision Record"
title: "ADR 0009: Git品質ゲート"
description: "Blogのstaged file、commit message、pull request titleをGit hookとCIで検証する方針を定める。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/0009-git-quality-gates.md"
tags: [blog, adr, architecture, git-hooks, conventional-commits]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-12T23:28:55Z
---

# ADR 0009: Git品質ゲート

## ステータス

承認済み

## 日付

2026-08-13

## コンテキスト

リポジトリ全体を検査するCIに加え、コミット直前の変更へ短時間でフィードバックし、履歴とpull requestの件名を一貫した形式に保つ必要がある。ローカルのGit hookは明示的に迂回できるため、hookだけでは共有履歴の規約を保証できない。

## 決定

コミット件名とpull requestタイトルはConventional Commits形式とし、`@commitlint/config-conventional`を継承したcommitlintで検証する。Huskyの`commit-msg` hookは作成中のコミットメッセージを検証する。CIはpull requestのタイトルとbaseからheadまでの全コミットを検証する。`main`への通常のfast-forward pushでは直前のrevisionから新しい`HEAD`までの追加コミットを検証する。直前のrevisionがall-zero、取得不能、または新しい`HEAD`の祖先でない場合は、履歴置換を含む検証範囲を安全に限定できないpushとして扱い、fail-closedで新しい`HEAD`から到達可能な全履歴を検証する。GitHub形式の件名とtwo-parent topologyを持つpull request merge commit本体だけは、検証済みタイトルを含むmerge metadataとして除外する。Dependabotも依存の種類に応じたConventional Commits形式のprefixを使う。

Huskyの`pre-commit` hookではlint-stagedを実行する。lint-stagedはstaged fileだけを対象とし、ADR 0008で定めた担当に従ってformatterを先に適用し、その後にlinterを実行する。formatterの変更はlint-stagedが再度stageする。型検査、未使用検査、buildを含むリポジトリ全体の検証はCIと`pnpm validate`が担当する。

## 検討した選択肢

- Git hookだけでコミット規約を検証する構成
- CIだけで整形、lint、コミット規約を検証する構成
- pre-commitで`pnpm validate`全体を実行する構成
- staged fileを変更せず、整形違反だけを報告する構成
- staged fileを自動整形し、Git hookとCIを組み合わせる構成

## 結果

通常のコミットでは対象ファイルの整形とlint、およびコミット件名の誤りを共有前に検出できる。Git hookを迂回した場合もpull requestと`main`のCIがコミット規約を検証する。force-pushや初回pushでは全履歴の検証コストが発生するが、履歴の置換によって未検証コミットが共有されることはない。pull requestタイトルの編集時にもCIが再実行され、squash commitの候補となる件名を早い段階で確認できる。

## 関連文書

- [ADR 0008](0008-toolchain-and-version-pinning.md)
- [README](../../README.md)
