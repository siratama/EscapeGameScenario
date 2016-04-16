package haxegame.game;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.text.TextViewer;
import com.dango_itimi.scenario.framework.Projector;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.geom.Point;
import com.dango_itimi.scenario.framework.Director;
import haxegame.game.scenario.Writer;

class Game
{
	private var itemHolder:Inventory;
	private var directionMap:DirectionMap;
	private var eventAreaSprite:EventAreaSprite;

	private var subtitle:Subtitle;
	private var director:Director;
	private var scenarioWriter:Writer;
	private var projector:Projector;

	private var mainFunction:Void->Void;

	public function new()
	{
		itemHolder = new Inventory();
		directionMap = new DirectionMap();
		eventAreaSprite = new EventAreaSprite();

		scenarioWriter = new Writer(itemHolder, directionMap, eventAreaSprite);

		subtitle = new Subtitle();
		projector = new Projector(itemHolder, subtitle.textViewer);
		director = new Director(projector, itemHolder, directionMap);

		mainFunction = waitUserControl;
	}
	public function run()
	{
		mainFunction();
	}
	private function waitUserControl()
	{
		
	}
	private function initializeToProject()
	{
		var checkPosition:Point = PointUtil.create(0, 0);
		director.progress(scenarioWriter.chapter.scene1, checkPosition);
		mainFunction = project;
	}
	private function project()
	{
		projector.run();
		subtitle.run();

		switch(projector.getEvent())
		{
			case ProjectorEvent.NONE: return;
			case ProjectorEvent.ITEM_CHANGE(itemChange):
				switch(itemChange)
				{
					case ItemChange.PICKED_UP(items):
						itemHolder.pickupSet(items);
						//play sound
					case ItemChange.REMOVED(items):
						itemHolder.removeSet(items);
						//play sound
					case ItemChange.EXCHANGED(pickedUp, removed):
						itemHolder.exchange(pickedUp, removed);
						//play sound
				}
			case ProjectorEvent.EQUIPED_INCORRECT_ITEM(incorrectItem):
				//play sound

			case ProjectorEvent.FINISH:
				mainFunction = waitUserControl;
		}
	}
}
