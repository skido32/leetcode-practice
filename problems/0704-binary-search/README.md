# 704. Binary Search

- 難易度: Easy
- リンク: https://leetcode.com/problems/binary-search/

## 問題（要約）
**小さい順に並んだ**（昇順）整数の配列 `nums` と、整数 `target` が与えられる。

`nums` の中に `target` があれば、その **番号（インデックス）** を返す。なければ `-1` を返す。

- 計算量は **O(log n)** で解くこと（テストで、配列を見る回数を数えている）

## 例
```
入力: nums = [-1, 0, 3, 5, 9, 12], target = 9
出力: 4   （nums[4] が 9）
```
```
入力: nums = [-1, 0, 3, 5, 9, 12], target = 2
出力: -1  （2 はない）
```

## 制約
- `1 <= nums.length <= 10^4`
- `-10^4 < nums[i], target < 10^4`
- `nums` の数字はすべて違う（重複なし）
- `nums` は昇順に並んでいる
