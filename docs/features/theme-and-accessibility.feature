# language: ja
@blog @theme @accessibility
機能: 読者の環境に合う操作可能な Blog を表示する
  読者として
  視覚設定や入力方法にかかわらず記事を利用するために
  theme と操作状態が明瞭なページを使いたい

  シナリオアウトライン: theme を選択する
    前提読者が Blog を開いている
    もし読者が theme "<theme>" を選択する
    ならばdocument の data-theme は "<theme>" になる
    かつ選択は次の訪問にも保持される

    例:
      | theme  |
      | system |
      | light  |
      | dark   |

  シナリオ: キーボードで追加記事を読み込む
    前提「さらに読み込む」ボタンが表示されている
    もし読者が Tab と Enter でボタンを実行する
    ならばfocus を失わず次の記事を取得する
    かつ読込中、成功、失敗、終端の状態を aria-live で通知する

  シナリオ: focus の位置を識別する
    もし読者がキーボードでリンク、theme 選択、読込ボタンを移動する
    ならば現在の focus が明瞭な視覚表示を持つ

  シナリオ: 動きを抑える設定を尊重する
    前提読者が prefers-reduced-motion を有効にしている
    もしtheme または一覧状態が変化する
    ならば装飾的な transition は短縮される
