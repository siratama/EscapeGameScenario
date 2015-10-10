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
	@event public var box(default, null):Event;
	@event public var window(default, null):Event;

	override private function setEvent()
	{
		//
		setUnqualifiedEvent(
			table, eventAreaSprite.table,
			["The table is broken."]
		);

		//
		setDefaultEvent(
			bed, eventAreaSprite.bed,
			["This is a bed."], ["The floor is broken."]
		);
		bed.requiredFinishEvents = [table];

		//
		setDefaultEvent(
			floor, eventAreaSprite.bed,
			["This is a floor."], ["You got a shield."]
		);
		floor.requiredFinishEvents = [bed];
		floor.gottenItems = [items.normalShield];

		//
		setDefaultEvent(
			box, eventAreaSprite.table,
			["This is a box."], ["You use a shield.", "You got a sword"]
		);
		box.requiredFinishEvents = [bed];
		box.requiredItems = [items.normalShield];
		box.removedItems = [items.normalShield];
		box.gottenItems = [items.normalSword];

		//
		setUnfiredEvent(
			window, eventAreaSprite.table,
			["This is a mirror"]
		);
	}
}

class Story2 extends GameStory
{
	@event public var table(default, null):Event;
	@event public var mirror(default, null):Event;
	@event public var box(default, null):Event;

	override private function setEvent()
	{
		//
		setUnqualifiedEvent(
			table, eventAreaSprite.table,
			["The table is broken."]
		);

		//
		setUnqualifiedEvent(
			mirror, eventAreaSprite.bed,
			["The mirror is broken."]
		);

		//
		setDefaultEvent(
			box, eventAreaSprite.bed,
			["This is a box."], ["The box is broken."]
		);
		box.requiredFinishEvents = [table, mirror];
	}
}

class Story3 extends GameStory
{
	@event public var table(default, null):Event;
	@event public var box(default, null):Event;

	override private function setEvent()
	{
		//
		setUnqualifiedEvent(
			table, eventAreaSprite.table,
			["This is a table."]
		);

		//
		setDefaultEvent(
			box, eventAreaSprite.bed,
			["This is a box."], ["The box is broken."]
		);
		box.requiredFinishEvents = [table];
	}
}
