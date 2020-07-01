# pinko mobile

![flutter test](https://github.com/team-e-org/mobile/workflows/flutter%20test/badge.svg?branch=develop)
[![codecov](https://codecov.io/gh/team-e-org/mobile/branch/develop/graph/badge.svg)](https://codecov.io/gh/team-e-org/mobile)

## Sprint

📌 [GitHub Projects](https://github.com/team-e-org/mobile/projects/1)

| name     | plan | period                |
|----------|------|-----------------------|
| Sprint 1 | N/A  | 2020/06/09-2020/06/12 |
| Sprint 2 | [#71](https://github.com/team-e-org/mobile/issues/71)  | 2020/06/15-2020/06/19 |
| Sprint 3 | [#146](https://github.com/team-e-org/mobile/issues/146)  | 2020/06/22-2020/06/26 |
| Sprint 4 | N/A  | 2020/06/29-2020/07/03 |


### 見積もり

`0.25h` `0.5h` `1h` `2h` のラベルをIssueにつけて見積もりをしています。

## お役立ち情報 🍵

### envファイルの設定

ビルド環境によって使用するenvファイルを切り替えています。

| build environment | env path        |
|-------------------|-----------------|
| dev               | .env/dev        |
| staging           | .env/staging    |
| production        | .env/production |

#### envに設定する項目

| name         | type   | description      |
|--------------|--------|------------------|
| API_ENDPOINT | string | the api endpoint (末尾のスラッシュは含めない) |

#### envファイルの例
```
API_ENDPOINT=http://api.example.com
```

### fronJson, toJson するためのコード生成

初めてビルドする時は必ず実行してください。

```bash
$ flutter packages pub run build_runner build
```

### splash screen の生成

スプラッシュスクリーンを更新する場合は以下のコマンドでスプラッシュスクリーンを生成できます。

```bash
$ flutter packages pub run flutter_native_splash:create
```
