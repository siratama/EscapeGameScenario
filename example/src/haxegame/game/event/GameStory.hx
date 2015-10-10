package haxegame.game.event;

import com.dango_itimi.escape_game.event.Story;
import com.dango_itimi.escape_game.event.Event;
import haxegame.game.item.GameItems;

class GameStory extends Story
{
	public var eventAreaSprite(null, set):EventAreaSprite;
	public function set_eventAreaSprite(eventAreaSprite:EventAreaSprite):EventAreaSprite
		return this.eventAreaSprite = eventAreaSprite;

	private var items:GameItems;

	public function new()
	{
		items = GameItems.instance;
		super();
	}
}

class Story1 extends GameStory
{
	@event public var table(default, null):Event;
	@event public var bed(default, null):Event;
	@event public var floor(default, null):Event;
	@event public var window(default, null):Event;

	override private function setEvent()
	{
		//
		setUnqualifired(
			table, eventAreaSprite.table,
			["どこかで音がしました。"]
		);

		//
		setDefault(
			bed, eventAreaSprite.bed,
			["ベッドです。"], ["床で音がしました。"]
		);
		bed.requiredFinishEvents = [table];

		//
		setDefault(
			floor, eventAreaSprite.bed,
			["床です。"], ["盾を手に入れた。"]
		);
		floor.requiredFinishEvents = [bed];
		floor.gottenItems = [items.normalSield];

		//
		setUnfired(
			window, eventAreaSprite.table, ["窓です。"]
		);
	}
}

class Story2 extends GameStory
{
	@event public var table(default, null):Event;

	override private function setEvent()
	{
		//
		setUnqualifired(
			table, eventAreaSprite.table,
			["なにもありません。"]
		);
	}
}

class Story3 extends GameStory
{
	@event public var table(default, null):Event;

	override private function setEvent()
	{
		//
		setUnqualifired(
			table, eventAreaSprite.table,
			["あいうえお"]
		);
	}
}
