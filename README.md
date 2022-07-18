# Makers Square
#### https://makers-square.work/
ログインページの「ゲストログイン」ボタンからゲストユーザーとしてログインできます。

## サイト概要

### サイトテーマ

自分の作ったハンドメイド作品を発表し、他の人が作った作品を楽しんだり、参考にしたりするハンドメイド作品の写真投稿サイト

### テーマを選んだ理由

趣味でハンドメイド作品を作っており、SNS に作品の写真を投稿しています。SNS には様々な写真が投稿されているので、ハンドメイド作品に特化したサイトがあれば、他の人の作品を見つけやすくなります。また、ハンドメイド作品の販売サイト・サービスはありますが、それらのサイトでは販売を目的としていない作品を発表しづらいので、気軽に作品を見てもらえる環境を作りたいと考え、このテーマにしました。

### ターゲットユーザ

ハンドメイド作品を作っている人。ハンドメイド作品を見るのが好きな人。

### 主な利用シーン

- 作った作品の写真を投稿、発表する。
- 他の人が投稿した作品の写真見て、自分の製作に参考になるものを探す。
- 作品に使用した材料などの情報の共有。

## 設計書

- [UI Flows](https://drive.google.com/file/d/1ZIoH7jiXzwiuJFh62OuFTY0jesrICvWM/view?usp=sharing)
- ワイヤーフレーム([会員](https://drive.google.com/file/d/1mbpSssUGkcGQQolbkwnU848980YjRolW/view?usp=sharing)/[管理者](https://drive.google.com/file/d/19gVdFyeUxsnFFx2Z3yv10MkBi5q75Ho_/view?usp=sharing))
- [ER図](https://drive.google.com/file/d/1Ks0YaPF2amLIoOcPFRtlo_AsGcRisX1b/view?usp=sharing)
- [テーブル定義書](https://docs.google.com/spreadsheets/d/1qo1Ob-d7PMNCu7seNtrgznqbCYNjqyDJBAdRxt1WLuM/edit?usp=sharing)
- [詳細設計書](https://docs.google.com/spreadsheets/d/1SCLDNOno2XNpoH9YpqERVLOfLdwIm8EY2hcCXoJnPBY/edit?usp=sharing)

## 機能一覧

- ユーザー認証
- 作品投稿機能
- コメント機能(非同期通信)
- いいね機能(非同期通信)
- フォロー機能(非同期通信)
- 作品の公開、非公開設定
- 材料登録機能
  - 作品作りに使用する材料を登録し、在庫管理に使用
- 作品材料登録機能
  - 作品に使用した材料を登録し、作品詳細に使用材料を表示
- 検索機能(ジャンル、キーワード、タグ)
- 管理者による管理機能(会員、作品、コメント)

## 開発環境

- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JS ライブラリ：jQuery
- IDE：Cloud9

## 使用素材
- [Font Awesome(アイコン)](https://fontawesome.com/)
