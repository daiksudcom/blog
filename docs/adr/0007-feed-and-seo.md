---
type: "Architecture Decision Record"
title: "ADR 0007: フィードと SEO"
description: "blog.daiksud.comを公開URL authorityとし、RSS、sitemap、robots、canonicalを同originへ揃えることを定める。"
resource: "https://github.com/daiksudcom/blog/blob/main/docs/adr/0007-feed-and-seo.md"
tags: [blog, adr, architecture, feed, seo]
timestamp: 2026-08-10T06:56:15Z
---

# ADR 0007: フィードと SEO

## ステータス

承認済み

## 日付

2026-08-10

## コンテキスト

Blog の公開 origin を crawler、feed reader、共有サービスへ一貫して伝える必要がある。

## 決定

`blog.daiksud.com` を Blog の公開 URL authority とする。`/rss.xml`、`/sitemap.xml`、`/robots.txt` を配信し、canonical、Open Graph URL、RSS channel/item/guid、sitemap location を同 origin の恒久 URL に揃える。production では Cloudflare Web Analytics を利用する。

## 検討した選択肢

- Content origin の URL を feed に使う構成
- Blog origin を一貫した公開 authority にする構成
- 外部 feed service に URL 生成を委譲する構成

## 結果

同じ記事を指す識別子が一つに収束し、検索、共有、購読の経路が一致する。Content API と生成 asset は公開記事の canonical にはならない。

## 関連文書

- [フィードと発見可能性仕様](../features/feed-and-discovery.feature)
