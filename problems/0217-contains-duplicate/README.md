# 217. Contains Duplicate

- 難易度: Easy
- リンク: https://leetcode.com/problems/contains-duplicate/

## 問題（要約）
整数の配列 `nums` が与えられる。
配列の中に **同じ値が2回以上出てくるものが1つでもあれば `true`**、すべての値がバラバラなら `false` を返す。

## 例
```
入力: nums = [1, 2, 3, 1]
出力: true
説明: 1 が2回出てくる
```
```
入力: nums = [1, 2, 3, 4]
出力: false
```
```
入力: nums = [1, 1, 1, 3, 3, 4, 3, 2, 4, 2]
出力: true
```

## 制約
- 1 <= nums.length <= 10^5
- -10^9 <= nums[i] <= 10^9

## 注意
- 返り値は必ず `true` か `false`（`nil` は不可）
- テストには要素数 10^5 の大きな入力があり、**2秒以内**に終わらないと失敗する（LeetCode の「時間切れ（TLE）」の再現）
