# EscapeGameScenario
クリックし アイテムを使用して進行する 脱出系ゲーム向けライブラリ

## 基礎概念

Book 内には Note が複数存在
Note 内には Event が進行順に存在

Book
Note Noe Note

Note
│
Event → Event → Event → Event → ...


Reader は Book を読む
読んだ結果を解析する事で、話が進んだか(Event が発火されたか)どうかの判定を行う
Reader.Progress

### 具体例

分岐・マルチストーリーを行いたい場合に Note を複数用意する。
一本道ストーリーの場合、Note は一つだけ用意すればよい。

### 機能

Note は複数並行して読み進めることが可能
Book.addReadingNote

読んでいる Note の進行状況を保ちつつ、別の Note へ切り替えが可能
Book.exchangeReadingNote

あらかじめ設定しておくことで、特定 Event発火 から別の Note へ切り替わる
Event.nextNote

エラーチェック
同じ Note 内の Event のクリック範囲が重なるとエラー
発火しない設定を行った Event の後に別の Event が追加されているとエラー
Novel.checkSettingError

###

### Note 

どの Event がどのクリック範囲かを設定する
setAreaMap(event:Event, hitArea:Rectangle)


### Event

以下の条件がそろった時 Event が発火する。
* Event が発火対象である
* Event 発火に必要なアイテムが全て揃っている
* この Event が発火するための他の Event が全て発火済みである


このEventが発火するのに必要な
requiredItems:Array<Item>

removedItems:Array<Item>

gottenItems:Array<Item>

requiredFinishEvents:Array<Event>

misfired:Bool

## How To Use 実装例

Note を任意数分用意する。
haxegame.game.scenario.Note[n]
Note 内には、発生する Event を定義する。
定義する Event のフィールドプロパティに @event を付与すると、Note コンストラクタ内で自動的に Event が new される。

Book を継承した Novel を用意し、用意したNoteをまとめる。
haxegame.game.scenario.Novel
定義する Note のフィールドプロパティに @note を付与すると、Book コンストラクタ内で自動的に Note が new される。

各 Note 内 Event がどのような振る舞いを行うかを決める Story を作成する。
haxegame.game.scenario.story.Story[n]
* Event が発生するための条件 クリック範囲の指定
* Event 発火時に取得したい任意データ(EventOption)の定義と Map への登録

Item を継承した GameItem を用意し、アイテムに必要なパラメータを定義する。
haxegame.game.item.GameItem

Items を継承した GameItems を用意し、アイテム一覧を定義する。
haxegame.game.item.GameItems
定義する Item のフィールドプロパティに @item を付与すると、Items コンストラクタ内で自動的に Item が new される。


シナリオライターを用意し、Note と Story を結びつける。
haxegame.game.scenario.Writer
その他、以下の設定を行う。
* 一番初めに読む Note を決める
* どの Event がどの Note に繋がるかを定義する(option)

Item を継承した GameItem を用意し、アイテムに必要なパラメータを定義する。
haxegame.game.item.GameItem

Items を継承した GameItems を用意し、アイテム一覧を定義する。
haxegame.game.item.GameItems
定義する Item のフィールドプロパティに @item を付与すると、Items コンストラクタ内で自動的に Item が new される。


シナリオライターを用意し、Note と Story を結びつける。
haxegame.game.scenario.Writer
その他、以下の設定を行う。
* 一番初めに読む Note を決める
* どの Event がどの Note に繋がるかを定義する(option)
* Event 発火時に行いたい動作を定義した EventOption を生成



### 未実装・未解決

StoryN 内で実行される Event の発火条件は、あらゆる Note 内 Event を参照可能にするべきである

現状は
同一クリック範囲の Event を次々と入れ替えたい状況に向いていないシステムになっている？

