@blog @isr @cloudflare @cache
Feature: Blog ページを Cloudflare キャッシュから再生成する
  運用者として
  低い応答時間と新しい Content を両立するために
  native Workers Caching を ISR として運用したい

  Background:
    Given production Worker で cache.enabled が true である
    And Blog 由来の応答には cache tag "content-blog-current" が付く
    And browser TTL は0秒、edge TTLは300秒、SWRは3600秒、stale-if-errorは86400秒である

  Scenario: キャッシュミスを SSR して保存する
    Given バージョン固有の cache key に応答がない
    When 読者が Blog ページを要求する
    Then Worker は Content を取得して SSR する
    And 応答を Cloudflare キャッシュへ保存する
    And CF-Cache-Status で MISS を観測できる

  Scenario: 有効なキャッシュを返す
    Given 同じバージョン固有 key に有効な応答がある
    When 読者が同じページを要求する
    Then Cloudflare は Worker の SSR 処理を迂回して応答する
    And CF-Cache-Status で HIT を観測できる

  Scenario: 期限切れ応答をバックグラウンド更新する
    Given edge TTLを過ぎSWR期間内の応答がある
    When 読者がページを要求する
    Then stale 応答を直ちに返す
    And バックグラウンドで Content を取得して応答を再生成する

  Scenario: Content 障害時に stale 応答を返す
    Given 86400秒以内の stale 応答がある
    And 再生成時の Content 取得が失敗する
    When 読者がページを要求する
    Then 利用可能な stale 応答を返す

  Scenario: Content リリース後に再生成する
    Given Content release が "content-blog-current" を purge した
    When 読者が Blog ページを要求する
    Then 現在の Content revision で SSR した応答を保存する
