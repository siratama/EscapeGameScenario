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
		setFloor();
		setBox();
		setWindow();
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
	private function setFloor()
	{
		setAreaMap(floor, eventAreaSprite.bed);
		floor.requiredFinishEvents = [bed];
		floor.gottenItems = [items.normalShield];
	}
	private function setBox()
	{
		setAreaMap(box, eventAreaSprite.table);
		box.requiredFinishEvents = [bed];
		box.requiredItems = [items.normalShield];
		box.removedItems = [items.normalShield];
		box.gottenItems = [items.normalSword];
	}
	private function setWindow()
	{
		setAreaMap(window, eventAreaSprite.table);
		window.misfired = true;
	}
}

class Story2 extends GameStory
{
	@event public var table(default, null):Event;
	@event public var mirror(default, null):Event;
	@event public var box(default, null):Event;

	override private function setEvent()
	{
		setAreaMap(table, eventAreaSprite.table);
		setAreaMap(mirror, eventAreaSprite.bed);

		setAreaMap(box, eventAreaSprite.bed);
		box.requiredFinishEvents = [table, mirror];
	}
}

class Story3 extends GameStory
{
	@event public var table(default, null):Event;
	@event public var box(default, null):Event;

	override private function setEvent()
	{
		setAreaMap(table, eventAreaSprite.table);

		setAreaMap(box, eventAreaSprite.bed);
		box.requiredFinishEvents = [table];
	}
}
