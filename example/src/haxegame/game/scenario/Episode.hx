package haxegame.game.scenario;

import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.direction.action.Action;
import com.dango_itimi.scenario.framework.direction.interaction.ClickChecker;
import com.dango_itimi.scenario.framework.area.AreaManager;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.direction.Cut;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.core.Event;
import haxegame.game.EventAreaSprite;

class Episode
{
	public var chapter(null, default):Chapter;
	public var items(null, default):Items;
	public var inventory(null, default):Inventory;
	public var eventAreaSprite(null, default):EventAreaSprite;
	public var directionMap(null, default):DirectionMap;
	public var areaManager(null, default):AreaManager;
	
	private var clickChecker:ClickChecker;

	public function new()
	{
		clickChecker = new ClickChecker();
	}
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
		areaManager.set(eventAreaSprite.table, event);

		var cut = new Cut(
			clickChecker,
			new Action()
		);
		var firedFilm = new FiredFilm(cut);

		event.enabledEventsAfterCompletion = [chapter.scene1.orange];
		event.disenabledEventsAfterCompletion  = [chapter.scene2.table];

		directionMap.set(event, firedFilm);
	}
	private function setOrange()
	{
		var event = chapter.scene1.orange;
		areaManager.set(eventAreaSprite.table, event);

		event.enabledEventsAfterCompletion = [chapter.scene1.banana];

		var itemChangeCut = new ItemChangeCut(
			ItemChange.PICKED_UP([items.sword]),
			clickChecker,
			"You got a " + items.sword.name
		);
		var firedFilm = new FiredFilm(itemChangeCut);

		directionMap.set(event, firedFilm);
	}
	private function setBanana()
	{
		var event = chapter.scene1.banana;
		areaManager.set(eventAreaSprite.bed, event);

		event.requiredCompletionEvents = [items.sword];
		event.enabledEventsAfterCompletion = [chapter.scene1.apple, chapter.scene2.table];

		var itemChangeCut = new ItemChangeCut(
			ItemChange.EXCHANGED([items.shield], [items.sword]),
			clickChecker,
			"You used a " + items.sword.name
		);
		var firedFilm = new FiredFilm(itemChangeCut);

		directionMap.set(event,  firedFilm);
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
		areaManager.set(eventAreaSprite.table, event);

		event.enabledEventsAfterCompletion = [chapter.scene2.bed];

		var cut = new Cut(
			clickChecker,
			new Action()
		);
		var firedFilm = new FiredFilm(cut);

		var cut = new Cut(
			clickChecker,
			new Action()
		);
		var equipedIncorrectItemFilm = new EquipedIncorrectItemFilm(cut, items.shield, 0);

		directionMap.set(event, firedFilm, equipedIncorrectItemFilm);
	}
	private function setBed()
	{
		var event = chapter.scene2.bed;
		areaManager.set(eventAreaSprite.bed, event);

		event.requiredCompletionEvents = [items.shield];

		var itemChangeCut = new ItemChangeCut(
			ItemChange.REMOVED([items.shield]),
			clickChecker,
			"You used a " + items.shield.name
		);
		var cut = new Cut(
			clickChecker,
			new Action()
		);
		var firedFilm = new FiredFilm(itemChangeCut);
		firedFilm.add(cut);

		directionMap.set(event, firedFilm);
	}
}

