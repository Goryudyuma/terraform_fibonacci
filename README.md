# Terraform Fibonacci

Terraform のモジュールを再帰的に呼び出し、フィボナッチ数列の第 `n` 項を計算する実験用サンプルです。
第0項を `0`、第1項を `1` とし、前の2項を足して順番に計算します。クラウドリソースやプロバイダーは使用しません。

## 必要環境

Terraform 1.15.0 以降が必要です。このバージョンで[モジュールの `source` に変数を使えるようになりました][release]。

## 使い方

リポジトリのルートで実行します（Bash / Zsh）。`n` には0以上の整数を指定してください。

```sh
export TF_VAR_n=10

terraform init &&
  echo 'module.f.result' | terraform console
```

出力は `55` です。[`terraform console`][console] で評価するため、`terraform apply` は不要です。

`n` を変えると読み込むモジュールも変わるので、`terraform init` からやり直してください。上記の `export` で、`init` と `console` に同じ値を渡しています。

## 仕組み

`a = 0`、`b = 1` から始め、次の状態を子モジュールに渡します。

```text
(n, a, b) → (n - 1, b, a + b)
```

`n = 0` になった階層の `a` が結果です。[`const = true`][const] を指定し、初期化時に `n` を評価できるようにしています。`n` が正なら同じモジュール、0なら子モジュールを持たない `stop` を読み込みます。
結果を返す条件分岐だけではモジュールの読み込みは止まらないので、終端では `source` を切り替えます。

```text
.
├── main.tf                     # 入力値の検証とモジュール呼び出し、結果の出力
└── modules
    ├── fibonacci/main.tf       # 2項の更新と再帰呼び出し
    └── stop/main.tf            # モジュール読み込みの終端
```

再帰で連結される名前が長くなりすぎないよう、モジュールの呼び出し名は1文字にしています。モジュールの階層と読み込み・評価のコストは `n` に応じて増えるため、大きな `n` の計算には向きません。

[release]: https://github.com/hashicorp/terraform/blob/v1.15.0/CHANGELOG.md
[console]: https://developer.hashicorp.com/terraform/cli/commands/console
[const]: https://developer.hashicorp.com/terraform/language/block/variable#const
