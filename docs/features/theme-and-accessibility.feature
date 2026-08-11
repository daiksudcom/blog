@blog @theme @accessibility
Feature: 読者の環境に合う操作可能な Blog を表示する
  読者として
  視覚設定や入力方法にかかわらず記事を利用するために
  theme と操作状態が明瞭なページを使いたい

  Scenario Outline: theme を選択する
    Given 読者が Blog を開いている
    When 読者が theme "<theme>" を選択する
    Then Blog の theme 設定は "<theme>" になる
    And 選択は次の訪問にも保持される

    Examples:
      | theme  |
      | system |
      | light  |
      | dark   |

  Scenario: キーボードで追加記事を読み込む
    Given 「さらに読み込む」ボタンが表示されている
    When 読者が Tab と Enter でボタンを実行する
    Then focus を失わず次の記事を取得する
    And 読込中、追加件数、失敗、終端の状態を aria-live で通知する

  Scenario: focus の位置を識別する
    When 読者がキーボードでリンク、theme 選択、読込ボタンを移動する
    Then 現在の focus が明瞭な視覚表示を持つ

  Scenario: 動きを抑える設定を尊重する
    Given 読者が prefers-reduced-motion を有効にしている
    When theme または一覧状態が変化する
    Then 装飾的な transition は短縮される
