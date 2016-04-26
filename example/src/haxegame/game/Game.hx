package haxegame.game;
import haxegame.game.scenario.Items;
import com.dango_itimi.scenario.framework.Appraiser;
import com.dango_itimi.scenario.framework.Scenario;
import com.dango_itimi.scenario.framework.area.AreaManager;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.text.TextViewer;
import com.dango_itimi.scenario.framework.Projector;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.geom.Point;
import com.dango_itimi.scenario.framework.Director;
import haxegame.game.scenario.Writer;

class Game
{
	private var items:Items;
	private var inventory:Inventory;
	private var directionMap:DirectionMap;
	private var eventAreaSprite:EventAreaSprite;
	private var areaManager:AreaManager;

	private var subtitle:Subtitle;
	private var director:Director;
	private var scenarioWriter:Writer;
	private var projector:Projector;

	private var mainFunction:Void->Void;

	public function new()
	{
		items = new Items();
		inventory = new Inventory();
		directionMap = new DirectionMap();
		eventAreaSprite = new EventAreaSprite();
		areaManager = new AreaManager();

		subtitle = new Subtitle();
		projector = new Projector(subtitle.textViewer);
		director = new Director(inventory, directionMap, areaManager);

		scenarioWriter = new Writer(items, inventory, directionMap, eventAreaSprite, areaManager);
		
		Appraiser.checkUnsetDirection(scenarioWriter.chapter, directionMap);
		Appraiser.checkUnsetEventIdInAreaMap(scenarioWriter.chapter, areaManager);

		initializeToWaitUserControl();
	}
	public function run()
	{
		mainFunction();
	}

	private function initializeToWaitUserControl()
	{
		mainFunction = waitUserControl;
	}
	private function waitUserControl()
	{
		var checkPosition:Point = PointUtil.create(0, 0);
		//Scenario.hasProgressEvent(areaManager, scenarioWriter.chapter.scene1, checkPosition);

		initializeToProject(checkPosition);
	}
	private function initializeToProject(checkPosition:Point)
	{
		var film = director.progress(scenarioWriter.chapter.scene1, checkPosition);
		if(film == null)
			initializeToWaitUserControl();
		else
		{
			projector.initialize(film);
			mainFunction = project;
		}
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
						inventory.pickupSet(items);
						//play sound
					case ItemChange.REMOVED(items):
						inventory.removeSet(items);
						//play sound
					case ItemChange.EXCHANGED(pickedUp, removed):
						inventory.exchange(pickedUp, removed);
						//play sound
				}
			case ProjectorEvent.EQUIPED_INCORRECT_ITEM(incorrectItem):
				//play sound
				"";

			case ProjectorEvent.FINISH:
				mainFunction = waitUserControl;
		}
	}
}