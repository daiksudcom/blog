---
type: "Architecture Decision Record"
title: "ADR 0003: Content API へのアクセス"
description: "versioned OpenAPIを契約の正本とし、Service BindingとHTTPSで同じschemaを検証することを定める。"
resource: "https://github.com/daiksudme/blog/blob/main/docs/adr/0003-content-api-access.md"
tags: [blog, adr, architecture, content-api-access]
status: stable
generated:
  by: "codex/gpt-5.6-sol"
  at: 2026-08-13T00:35:00Z
---

# ADR 0003: Content API へのアクセス

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

SSR、preview、ローカル開発、ブラウザーの追加読込は異なる通信経路を持つが、同じ Content schema とエラー契約を利用する必要がある。Content専用の配布packageへ契約を複製すると、APIとpackageのversion laneが分かれ、どちらが正本か曖昧になる。

## 決定

Contentが公開するversioned OpenAPIを唯一の公開契約とする。Blogは採用するplain SemVerを明示して型とruntime validatorを生成し、生成結果をBlogのbuild入力として固定する。`@daiksudme/content` client packageは使用しない。

本番SSRはCloudflare Service Binding、previewとローカルはHTTPS、ブラウザーの追加読込は`https://content.daiksud.me/v1/blog`へのHTTPSを使う。各transportはWeb標準の`Request`と`Response`へ正規化し、同じ生成済みvalidatorで応答を表示前に検証する。OpenAPI majorが変わる場合は旧major routeを利用したまま新契約への対応を先にDeployし、移行を独立して検証する。

## 検討した選択肢

- 各画面が独自に fetch と schema を実装する構成
- すべての環境で public HTTPS を使う構成
- 共通 client package と交換可能な transport を使う構成
- OpenAPIを正本としてBlog内にconsumerを生成する構成

## 結果

本番SSRはCloudflare内の低遅延な経路を利用でき、previewとブラウザーも同じversioned契約を利用できる。schema不整合は表示前に検出され、Content APIとclient packageを別々にReleaseする必要がなくなる。代わりに、OpenAPI更新時は生成差分とruntime validationをBlog側でレビューする。

## 関連文書

- [記事一覧仕様](../features/article-list.feature)
- [タグ一覧仕様](../features/tag-list.feature)
- [記事ページ仕様](../features/article-page.feature)
- [Content API 仕様](https://github.com/daiksudme/content/tree/main/docs/features)
