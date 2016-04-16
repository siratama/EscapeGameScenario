package haxegame.game.scenario;

import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.direction.Cut;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.core.Event;
import haxegame.game.EventAreaSprite;

class Episode
{
	public var chapter(null, default):Chapter;
	public var itemHolder(null, default):Inventory;
	public var eventAreaSprite(null, default):EventAreaSprite;
	public var directionMap(null, default):DirectionMap;

	public function write(){}
}

class Episode1 extends Episode
{
	override public function write()
	{
		setApple();
		setOrange();
		setBanana();
	}
	private function setApple()
	{
		var event = chapter.scene1.apple;
		event.enable();
		chapter.scene1.setAreaMap(event, eventAreaSprite.table);

		event.enabledEventsAfterCompletion = [chapter.scene1.orange];
	}
	private function setOrange()
	{
		var event = chapter.scene1.orange;
		chapter.scene1.setAreaMap(event, eventAreaSprite.table);

		event.enabledEventsAfterCompletion = [chapter.scene1.banana];

		var itemChangeCut = new ItemChangeCut();

		itemChangeCut.text = "You got a " + chapter.items.sword.name;
		itemChangeCut.itemChange = ItemChange.PICKED_UP([chapter.items.sword]);
		directionMap.set(event, null, [itemChangeCut], null);
	}
	private function setBanana()
	{
		var event = chapter.scene1.banana;
		chapter.scene1.setAreaMap(event, eventAreaSprite.bed);

		event.requiredCompletionEvents = [chapter.items.sword];
		event.enabledEventsAfterCompletion = [chapter.scene1.apple];

		var itemChangeCut = new ItemChangeCut();
		itemChangeCut.itemChange = ItemChange.REMOVED([chapter.items.sword]);
		directionMap.set(event, null, [itemChangeCut], null);
	}
}
class Episode2 extends Episode
{
	override public function write()
	{
		setTable();
		setBed();
	}
	private function setTable()
	{
		var event = chapter.scene2.table;
		event.enable();
		chapter.scene2.setAreaMap(event, eventAreaSprite.table);
	}
	private function setBed()
	{
		var event = chapter.scene2.bed;
		event.enable();
		chapter.scene2.setAreaMap(event, eventAreaSprite.bed);

		event.endless = true;
	}
}

