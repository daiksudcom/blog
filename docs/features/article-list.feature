@blog @content @infinite-scroll
Feature: 記事一覧を継続的に読み込む
  読者として
  公開日時の新しい記事から順に途切れなく探すために
  cursor を使って記事を12件ずつ読み込みたい

  Background:
    Given Content API には公開済み記事が公開日時の降順で存在する

  Rule: 最初の一覧は SSR し、続きは同じ順序契約で追記する

    Scenario: 最初の12件を表示する
      Given 公開済み記事が20件ある
      When 読者が "https://blog.daiksud.com/" を開く
      Then 最初の12件が SSR された HTML に含まれる
      And 各記事は "https://blog.daiksud.com/{slug}/" にリンクする
      And 次の取得に使う opaque cursor が保持される

    Scenario: viewport の末尾から次の12件を自動で読み込む
      Given 一覧に12件と次の opaque cursor が表示されている
      When IntersectionObserver が一覧末尾を検出する
      Then Content API へ limit=12 と cursor を指定して要求する
      And 既存記事と重複しない次の12件を順序どおり末尾へ追加する

    Scenario: ボタンで次の項目を読み込む
      Given 「さらに読み込む」ボタンにキーボード focus がある
      When 読者がボタンを実行する
      Then 自動読込と同じ cursor と状態機械で次の項目を取得する
      And 追加件数を aria-live 領域で通知する

    Scenario: 一覧の終端へ到達する
      Given Content API の応答に次の cursor がない
      When 応答の記事を一覧へ追加する
      Then 一覧の終端を読者へ通知する
      And 読込トリガーを完了状態にする

    Scenario: 追加読込を再試行する
      Given 追加読込が通信エラーになっている
      When 読者が再試行を実行する
      Then 失敗時と同じ cursor で一度だけ要求する
      And 成功時は既存記事を保ったまま結果を追記する
