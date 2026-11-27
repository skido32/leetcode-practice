# 704. Binary Search 振り返り

## 使ったパターン
- 二分探索: **ソート済み** の配列で、真ん中を見て、探す範囲を半分ずつ捨てていく
- 配列は切り取らず、探す範囲を `left` と `right` の **番号** で表す
- `nums[mid]` が小さい → `left = mid + 1`、大きい → `right = mid - 1`（`mid` は調べ終わったので1つずらす）
- ループの条件は `left <= right`（要素が1個残ったときも調べるため）

## 計算量
| | 時間 | 空間 |
|---|---|---|
| 前から順に探す | O(n) | O(1) |
| 配列を `slice` で切り取って半分にする | O(n)（毎回コピーする） | O(n) |
| `left` / `right` の二分探索 | **O(log n)** | O(1) |

- log n = 「n を何回半分にしたら 1 になるか」。1万なら約14回、100万でも約20回

## つまずいた点
- 最初は配列を `slice` で切り取って半分にしていた
  - 切り取った配列での番号を返してしまう（元の配列の番号とずれる）
  - `slice(開始, -1)` は `nil` を返す（2番目は「個数」）
  - `slice` は新しい配列を作るので O(n)
- `left = 0 right = ...` と1行に2つ書いて文法エラー → 2行に分ける / `;` / 多重代入 `left, right = 0, nums.size - 1`

## 次に同じ問題を見たら
「ソート済み」「O(log n)」= 二分探索。配列は切らずに `left` / `right` を動かす。
```ruby
left, right = 0, nums.size - 1
while left <= right
  mid = (left + right) / 2
  return mid if nums[mid] == target
  nums[mid] < target ? left = mid + 1 : right = mid - 1
end
-1
```
