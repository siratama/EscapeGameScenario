package haxegame.game;

import haxegame.game.scenario.Items;
import com.dango_itimi.scenario.framework.Scenario;
import com.dango_itimi.scenario.framework.direction.interaction.ClickChecker;
import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.area.AreaManager;
import com.dango_itimi.scenario.framework.Appraiser;
import com.dango_itimi.scenario.framework.Projector;
import com.dango_itimi.scenario.framework.Director;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.item.Inventory;
import haxegame.game.scenario.Writer;
import haxegame.game.scenario.Chapter;
import com.dango_itimi.geom.Point;
import massive.munit.Assert;

using com.dango_itimi.geom.Point.PointUtil;

class FrameworkTest
{
	private var items:Items;
	private var inventory:Inventory;
	private var directionMap:DirectionMap;
	private var eventAreaSprite:EventAreaSprite;
	private var areaManager:AreaManager;

	private var scenarioWriter:Writer;
	private var chapter:Chapter;
	private var subtitle:Subtitle;
	private var director:Director;
	private var projector:Projector;

	private static var TABLE_POSITION = PointUtil.create(0, 0);
	private static var BED_POSITION = PointUtil.create(2, 0);
	private static var OUT_POSITION = PointUtil.create(0, 2);

	public function new()
	{

	}

	@BeforeClass
	public function beforeClass():Void
	{
	}

	@AfterClass
	public function afterClass():Void
	{
	}

	@Before
	public function setup():Void
	{
		items = new Items();
		inventory = new Inventory();
		directionMap = new DirectionMap();
		eventAreaSprite = new EventAreaSprite();
		areaManager = new AreaManager();

		subtitle = new Subtitle();
		projector = new Projector(subtitle.textViewer);
		director = new Director(inventory, directionMap, areaManager);
	}

	@After
	public function tearDown():Void
	{
	}

	private function writeScenario()
	{
		try{
			scenarioWriter = new Writer(items, inventory, directionMap, eventAreaSprite, areaManager);
			Assert.isTrue(true);
		}
		catch(e:Dynamic) Assert.fail(e);

		chapter = scenarioWriter.chapter;

		try{
			Appraiser.checkUnsetDirection(chapter, directionMap);
			Assert.isTrue(true);
		}
		catch(e:Dynamic) Assert.fail(e);

		try{
			Appraiser.checkUnsetEventIdInAreaMap(chapter, areaManager);
			Assert.isTrue(true);
		}
		catch(e:Dynamic) Assert.fail(e);
	}

	@Test
	public function testDirectorProgress():Void
	{
		writeScenario();

		Assert.isTrue(chapter.scene1.apple.enabled);
		Assert.isFalse(chapter.scene1.orange.enabled);
		Assert.isTrue(chapter.scene2.table.enabled);

		var film:Film;

		Assert.isFalse(Scenario.hasProgressEvent(areaManager, scenarioWriter.chapter.scene1, OUT_POSITION));
		film = director.progress(chapter.scene1, OUT_POSITION);
		Assert.isTrue(film == null);

		Assert.isTrue(Scenario.hasProgressEvent(areaManager, scenarioWriter.chapter.scene1, TABLE_POSITION));
		film = director.progress(chapter.scene1, TABLE_POSITION);
		Assert.isTrue(film != null);
		Assert.isFalse(chapter.scene1.apple.enabled);
		Assert.isFalse(chapter.scene2.table.enabled);
		Assert.isTrue(chapter.scene1.orange.enabled);

		film = director.progress(chapter.scene1, TABLE_POSITION);
		Assert.isFalse(chapter.scene1.orange.enabled);
	}

	private function playProjector(film:Film, skipDirection:Bool = false)
	{
		projector.initialize(film);

		var count = 100;
		while(count > 0)
		{
			projector.run();
			if(projector.isPlaying() && skipDirection)
				cast(projector.displayCut.skipOperation, ClickChecker).clicked = true;

			else if(projector.isWaitingClapperboard())
				cast(projector.displayCut.clapperboard, ClickChecker).clicked = true;

			switch(projector.getEvent())
			{
				case ProjectorEvent.NONE: "";
				case ProjectorEvent.ITEM_CHANGE(itemChange): inventory.change(itemChange);
				case ProjectorEvent.EQUIPED_INCORRECT_ITEM(item): "";
				case ProjectorEvent.FINISH: break;
			}
			count--;
		}
		if(count == 0){
			Assert.fail("projector infinite roop");
		}
	}

	@Test
	public function testProjector():Void
	{
		writeScenario();

		var film:Film;
		film = director.progress(chapter.scene1, TABLE_POSITION);
		playProjector(film);

		//inventory change
		Assert.isTrue(inventory.set.length == 0);
		film = director.progress(chapter.scene1, TABLE_POSITION);
		playProjector(film);
		Assert.isTrue(inventory.set.length == 1);
		Assert.isTrue(inventory.set[0] == items.sword);

		inventory.selectFromIndex(0);

		//item exchanged
		film = director.progress(chapter.scene1, BED_POSITION);
		playProjector(film);
		Assert.isTrue(inventory.set.length == 1);
		Assert.isTrue(inventory.set[0] == items.shield);

		//equiped incorrect item cut
trace("aaaaaaaaaaaaaa");
		inventory.select(items.shield);
		film = director.progress(chapter.scene2, TABLE_POSITION);
		playProjector(film);

		/*
		//inventory.unselect(items.shield);
		film = director.progress(chapter.scene2, TABLE_POSITION);
		playProjector(film);
		*/
	}

	@Test
	public function testPlayingProjectorSkip():Void
	{
		writeScenario();
		var film:Film = director.progress(chapter.scene1, TABLE_POSITION);
		playProjector(film, true);
	}
}