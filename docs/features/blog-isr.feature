@blog @isr @cloudflare @cache
Feature: Blog ページを edge cache から安全に再生成する
  運用者として
  低い応答時間と新しい Content を両立するために
  cache された応答を利用しながら現在の Content へ更新したい

  Background:
    Given production の Blog 応答は "Cache-Control: public, max-age=0" を返す
    And Blog 応答は "Cloudflare-CDN-Cache-Control: public, max-age=300, stale-while-revalidate=3600, stale-if-error=86400" を返す
    And Blog 応答の Cache-Tag は "content-blog-current" を含む

  Scenario: キャッシュミスを SSR して保存する
    Given 現在の deployment には要求する URL の cache 応答がない
    When 読者が Blog ページを要求する
    Then 現在の Content revision から SSR された HTML を受け取る
    And CF-Cache-Status で MISS を観測できる
    And 続く同じ URL への要求で CF-Cache-Status の HIT を観測できる

  Scenario: 有効なキャッシュを返す
    Given 現在の deployment に同じ URL の有効な cache 応答がある
    When 読者が同じページを要求する
    Then cache された HTML を受け取る
    And CF-Cache-Status で HIT を観測できる

  Scenario: 期限切れ応答をバックグラウンド更新する
    Given edge TTLを過ぎSWR期間内の応答がある
    When 読者がページを要求する
    Then stale 応答を直ちに返す
    And 更新完了後の同じ URL への要求では現在の Content revision の応答を受け取る

  Scenario: Content 障害時に stale 応答を返す
    Given 86400秒以内の stale 応答がある
    And 再生成時の Content 取得が失敗する
    When 読者がページを要求する
    Then 利用可能な stale 応答を返す

  Scenario: Feature Flag variant 間で cache を分離する
    Given default-off の機能に由来する Blog 応答が edge cache にある
    When その機能を Product Release する
    And 読者が同じ Blog ページを要求する
    Then off variant の応答を返さない
    And on variant の機能を含む Blog 応答を返す

  Scenario: Content リリース後に再生成する
    Given Content release が "content-blog-current" を purge した
    When 読者が Blog ページを要求する
    Then purge 前の revision ではなく現在の Content revision で SSR した応答を受け取る
    And CF-Cache-Status で MISS を観測できる
    And 続く同じ URL への要求で現在の Content revision と CF-Cache-Status の HIT を観測できる
