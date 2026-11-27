# 35. Search Insert Position

- 難易度: Easy
- リンク: https://leetcode.com/problems/search-insert-position/

## 問題（要約）
**小さい順に並んだ**（昇順）、重複のない整数の配列 `nums` と、整数 `target` が与えられる。

- `target` が `nums` の中にあれば、その **番号** を返す
- なければ、「`target` を入れるとしたら、並び順を崩さずに入れられる番号」を返す

計算量は **O(log n)** で解くこと（テストで、配列を見る回数を数えている）。

## 例
```
入力: nums = [1, 3, 5, 6], target = 5
出力: 2   （nums[2] が 5）
```
```
入力: nums = [1, 3, 5, 6], target = 2
出力: 1   （1 と 3 の間 → 入れると [1, 2, 3, 5, 6] で、2 は1番目）
```
```
入力: nums = [1, 3, 5, 6], target = 7
出力: 4   （一番後ろ → [1, 3, 5, 6, 7]）
```

## 制約
- `1 <= nums.length <= 10^4`
- `-10^4 <= nums[i], target <= 10^4`
- `nums` の数字はすべて違い、昇順に並んでいる
