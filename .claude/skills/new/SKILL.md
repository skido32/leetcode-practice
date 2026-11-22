---
name: new
description: LeetCode の問題を1問用意する（README・空の solution.rb・テスト）。「/new 1」「Two Sum をやりたい」など、新しい問題に取り組むとき。
---

# 新しい問題を用意する

引数: 問題番号（例 `1`）または問題名。なければ `roadmap.md` の最初の未チェック問題を使う。

1. `problems/NNNN-slug/`（番号は4桁ゼロ埋め、slug は LeetCode の URL と同じ）を作る。既にあれば上書きせず、そのまま続きをやるか聞く。
2. `README.md`:
   - タイトル、難易度、リンク `https://leetcode.com/problems/<slug>/`
   - 問題の要約（**原文コピーではなく自分の言葉で**、日本語）
   - 例 2〜3個、制約
   - **パターン名やヒントは書かない**（ネタバレ防止）
3. `solution.rb`: LeetCode の Ruby テンプレートと同じトップレベルメソッド。YARD 風の `# @param` / `# @return` コメント付きで、本体は空（`end` だけ）。連結リスト・木の問題は先頭に `require_relative "../../lib/helpers"`。
4. `test_solution.rb`: `require "minitest/autorun"` と `require_relative "solution"`。README の例 + エッジケース（空・要素1つ・重複・負数など、問題に合うもの）を 4〜8 テスト。テスト名からは解法がわからないようにする。リスト・木は `Helpers.build_list` / `Helpers.build_tree` などを使う。
5. `notes.md`: 見出しだけのテンプレート（`## 使ったパターン` `## 計算量` `## つまずいた点` `## 次に同じ問題を見たら`）。
6. `bin/t <番号>` を実行して、テストが「失敗する」（未実装）ことを確認する。
7. 学習者に伝える: ファイルの場所、`bin/t <番号>` でテストできること、困ったら `/hint`、書けたら `/review`。目安時間は Easy 20分。**解き方のヒントは言わない。**
