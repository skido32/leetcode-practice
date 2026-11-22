# 217. Contains Duplicate 振り返り

## 使ったパターン
- Set（集合）は同じ値を1つしか持てない → Set にして要素数が減れば重複あり

```ruby
require "set"
Set.new(nums).size != nums.size
```

## 計算量
| | 時間 | 空間 |
|---|---|---|
| Set に変換して比べる | O(n) | O(n) |
| （参考）見つけた瞬間に return する Set 版 | O(n) | O(n) ※早く終わることがある |
| （参考）sort して隣どうしを比べる | O(n log n) | 追加メモリを減らせる |

## つまずいた点
- Set の書き方（`require "set"`, `Set.new`, `size`）が浮かばなかった
- `==` と `!=` が逆で、結果が全部反対になった → Expected/Actual が全部逆なら条件の向きを疑う

## 次に同じ問題を見たら
重複チェックは Set。メソッドの書き方: `require "set"` → `Set.new(配列)` → `size` で比べる（`nums.uniq.size` でも同じ）。
