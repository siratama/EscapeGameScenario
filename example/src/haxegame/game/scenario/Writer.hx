package haxegame.game.scenario;
import com.dango_itimi.scenario.framework.area.AreaManager;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.item.Inventory;
import haxegame.game.area.EventAreas;
import haxegame.game.scenario.Episode;

class Writer
{
	public var chapter(default, null):Chapter;

	private var items:Items;
	private var inventory:Inventory;
	private var eventAreas:EventAreas;
	private var directionMap:DirectionMap;
	private var areaManager:AreaManager;
	private var actions:Actions;
	private var interactions:Interactions;

	private var episodeSet:Array<Episode>;
	public var episode1(default, null):Episode1;
	public var episode2(default, null):Episode2;

	public function new(items:Items, inventory:Inventory, directionMap:DirectionMap, eventAreaSprite:EventAreas, areaManager:AreaManager, actions:Actions, interactions:Interactions)
	{
		this.items = items;
		this.inventory = inventory;
		this.directionMap = directionMap;
		this.eventAreas = eventAreaSprite;
		this.areaManager = areaManager;
		this.actions = actions;
		this.interactions = interactions;

		chapter = new Chapter();

		areaManager.register(chapter);

		episodeSet = [];
		execute(Episode1);
		execute(Episode2);
	}
	private function execute(episodeClass:Class<Episode>)
	{
		var episode:Episode = Type.createInstance(episodeClass, []);

		episode.inventory = inventory;
		episode.directionMap = directionMap;
		episode.eventAreas = eventAreas;
		episode.chapter = chapter;
		episode.items = items;
		episode.areaManager = areaManager;
		episode.actions = actions;
		episode.interactions = interactions;

		episode.write();
		episodeSet.push(episode);
	}
}
