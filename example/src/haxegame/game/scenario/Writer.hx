package haxegame.game.scenario;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.direction.Direction;
import com.dango_itimi.scenario.framework.item.ItemHolder;
import com.dango_itimi.scenario.core.Event;
import haxegame.game.EventAreaSprite;
import haxegame.game.scenario.Episode;

class Writer
{
	public var chapter(default, null):Chapter;

	private var itemHolder:ItemHolder;
	private var eventAreaSprite:EventAreaSprite;
	private var directionMap:DirectionMap;

	private var episodeSet:Array<Episode>;
	public var episode1(default, null):Episode1;
	public var episode2(default, null):Episode2;

	public function new(itemHolder:ItemHolder, directionMap:DirectionMap, eventAreaSprite:EventAreaSprite)
	{
		this.itemHolder = itemHolder;
		this.directionMap = directionMap;
		this.eventAreaSprite = eventAreaSprite;

		chapter = new Chapter();

		episodeSet = [];
		execute(Episode1);
		execute(Episode2);
	}
	private function execute(episodeClass:Class<Episode>)
	{
		var episode:Episode = Type.createEmptyInstance(episodeClass);

		episode.itemHolder = itemHolder;
		episode.directionMap = directionMap;
		episode.eventAreaSprite = eventAreaSprite;
		episode.chapter = chapter;

		episode.write();
		episodeSet.push(episode);
	}
}
