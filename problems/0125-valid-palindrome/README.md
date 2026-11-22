# 125. Valid Palindrome

- 難易度: Easy
- リンク: https://leetcode.com/problems/valid-palindrome/

## 問題（要約）
文字列 `s` が与えられる。次の手順で整えたあと、**前から読んでも後ろから読んでも同じ（回文）** なら `true`、そうでなければ `false` を返す。

1. 大文字はすべて小文字として扱う
2. 英字と数字 **以外**（スペース、記号、`_` など）はすべて無視する

## 例
```
入力: s = "A man, a plan, a canal: Panama"
出力: true
説明: 整えると "amanaplanacanalpanama" → 回文
```
```
入力: s = "race a car"
出力: false
説明: 整えると "raceacar" → 回文ではない
```
```
入力: s = " "
出力: true
説明: 整えると空文字 "" になる。空文字は回文として扱う
```

## 制約
- 1 <= s.length <= 2 * 10^5
- `s` は表示可能な ASCII 文字のみ

## 注意
- 返り値は必ず `true` か `false`（`nil` は不可）
- 長さ 2 * 10^5 のテストが **2秒以内** に終わらないと失敗する

## 発展
追加メモリ O(1) で解けるか？
