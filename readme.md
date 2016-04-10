# EscapeGameScenario
クリックで進行する 脱出系ゲーム向けライブラリ

## 概念


### Event

#### プロパティ

* enabled
	* その Event が実行可能対象であるかどうかを判定するプロパティ
	* true に設定される事で Reader からの検出が可能になる
		* 同 hitArea(Rectangle) 内に enabled == true の Event が複数検出される場合 Reader はエラーを投げる

* endless
	* 実行が完了しない Event である事を示すプロパティ
	* 例えば、背景オブジェクトをクリックして「これは○○です。」といった、テキストのみを表示したい場合 true に設定する
	* enabled が true になることで「実行対象にはなるが実行完了は不可」という状態になる

* completed
	* Event が実行完了したかどうかを示すプロパティ
	* enabled が false の状態の Event に対し、実行完了前なのか 実行完了後なのか、判定するためのプロパティ
		* enabled が true の状態の Event は、実行完了前である
	* 開発側は意識する必要はないため private
	
#### 図解
	
#### 設計未解決思想

ループイベント問題

例えば Ａ, Ｂ, Ｃ, Ｄ のイベントが存在し、以下のようにＣのイベント完了後に有効になるイベントはＡに設定したとする。

Ａ.enabledEventsAfterCompletion = [Ｂ];
Ｂ.enabledEventsAfterCompletion = [Ｃ];
Ｃ.enabledEventsAfterCompletion = [Ａ];

Ａ→Ｂ→Ｃ
↑←←←↓

イベントＤの完了条件は、イベントＡの完了とする。

Ｄ.requiredCompletionEvents = [Ａ];

ここで、Ｃが完了した時、以下の状況が発生する。

(1)Ｃ.complete();
↓
(2)Ａ.enable();
↓
(3)Ｄ.isCompletable() == false;

仮に、Ｄが(1)の前ですでにイベント完了状態(completed == true)だったとしても、
Ｄは再びイベントが完了できない状態(Ｄ.isCompletable() == false)になる。

この状況に何か問題は発生しないか？

requiredCompletionEvents 内の Event 全てが completed == true の時のみに、
自身が completed == true 状態になるので、
completed == true にも関わらず
isCompletable() == false はロジックエラーである？

そんなことはない？
「一度は完了したが、他のイベントの影響により 完了が不可な状況になった」という状況はありえる。
(completed ではなく completed once か？)

この状況で、描画側がどういう表示にするかは、描画処理側の対処次第、となりそう。
ループイベントでは この状況が発生する旨を マニュアル記述で留意させる。
芋づる式であらゆるイベントがこの状況になる可能性があるため、ループイベントの使用は注意が必要である。

------------------------------------

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

