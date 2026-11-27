# 35. Search Insert Position 振り返り

## 使ったパターン
- 二分探索（704 と同じ形）。違いは **見つからなかったときに `left` を返す** だけ
- ループを抜けたとき、`right = left - 1` で、入れる場所を `right` と `left` が挟んでいる
  - `left` より左はすべて `target` より小さい、`left` から右はすべて `target` より大きい → `left` が入れる場所
  - 先頭より前なら `left = 0`、最後より後ろなら `left = nums.size` になるので、端の場合分けがいらない

## 計算量
| | 時間 | 空間 |
|---|---|---|
| 二分探索 | O(log n) | O(1) |

## つまずいた点
- `if nums[mid] = target` と `=`（代入）を書いた → いつも真になり、しかも `nums` を書き換える。比べるのは `==`
- `mid = left + right - 1` → 真ん中は `(left + right) / 2`
- 最後に `left + right` を返していた → 抜けたときの `left` と `right` を表にすると、`left` が答えだと分かる

## 次に同じ問題を見たら
二分探索をそのまま書いて、最後は `return left`（「入れる場所」「target 以上の最初の位置」）。
