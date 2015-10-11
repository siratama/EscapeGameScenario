package haxegame.game.event;

import haxegame.game.event.EventOption;
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
		setTable();
		setBed();

		/*
		//
		setAreaMap(
			floor, eventAreaSprite.bed,
			["This is a floor."], ["You got a shield."]
		);
		floor.requiredFinishEvents = [bed];
		floor.gottenItems = [items.normalShield];

		//
		setAreaMap(
			box, eventAreaSprite.table,
			["This is a box."], ["You use a shield.", "You got a sword"]
		);
		box.requiredFinishEvents = [bed];
		box.requiredItems = [items.normalShield];
		box.removedItems = [items.normalShield];
		box.gottenItems = [items.normalSword];

		//
		setAreaMap(
			window, eventAreaSprite.table,
			["This is a mirror"]
		);
		window.setUnfired();
		*/
	}
	private function setTable()
	{
		setAreaMap(table, eventAreaSprite.table);

		var texts = new Texts();
		texts.fired = ["The table is broken."];
		table.option = EventOptionCreator.create(texts);
	}
	private function setBed()
	{
		setAreaMap(bed, eventAreaSprite.bed);
		bed.requiredFinishEvents = [table];

		var texts = new Texts();
		texts.checked = ["This is a bed."];
		texts.fired = ["The floor is broken."];
		bed.option = EventOptionCreator.create(texts);
	}
}

class Story2 extends GameStory
{
	@event public var table(default, null):Event;
	@event public var mirror(default, null):Event;
	@event public var box(default, null):Event;

	override private function setEvent()
	{
		/*
		//
		setAreaMap(
			table, eventAreaSprite.table,
			["The table is broken."]
		);

		//
		setAreaMap(
			mirror, eventAreaSprite.bed,
			["The mirror is broken."]
		);

		//
		setAreaMap(
			box, eventAreaSprite.bed,
			["This is a box."], ["The box is broken."]
		);
		box.requiredFinishEvents = [table, mirror];
		*/
	}
}

class Story3 extends GameStory
{
	@event public var table(default, null):Event;
	@event public var box(default, null):Event;

	override private function setEvent()
	{
		/*
		//
		setAreaMap(
			table, eventAreaSprite.table,
			["This is a table."]
		);

		//
		setAreaMap(
			box, eventAreaSprite.bed,
			["This is a box."], ["The box is broken."]
		);
		box.requiredFinishEvents = [table];
		*/
	}
}
