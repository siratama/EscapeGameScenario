package haxegame.game;

import haxegame.game.area.DummyEventAreas;
import haxegame.game.area.EventAreas;
import haxegame.game.scenario.Items;
import haxegame.game.scenario.Writer;
import com.dango_itimi.scenario.framework.Projector;
import com.dango_itimi.scenario.framework.text.Subtitle;
import com.dango_itimi.scenario.framework.save.Recorder;
import com.dango_itimi.scenario.framework.Director;
import com.dango_itimi.scenario.framework.area.AreaManager;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.framework.Appraiser;
import massive.munit.Assert;

class Test
{
	private var items:Items;
	private var inventory:Inventory;
	private var directionMap:DirectionMap;
	private var areaManager:AreaManager;
	private var director:Director;
	private var recorder:Recorder;
	private var projector:Projector;
	private var subtitle:Subtitle;
	private var actions:Actions;
	private var interactions:Interactions;
	private var scenarioWriter:Writer;
	private var eventAreas:EventAreas;

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
		areaManager = new AreaManager();
		recorder = new Recorder(null);
		director = new Director(inventory, directionMap, areaManager, recorder);

		subtitle = new Subtitle(0, 0);
		projector = new Projector(subtitle);

		actions = new Actions();
		interactions = new Interactions();

		eventAreas = new DummyEventAreas(); //dummy
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function testInitialized():Void
	{
		try{
			scenarioWriter = new Writer(items, inventory, directionMap, eventAreas, areaManager, actions, interactions);
			Assert.isTrue(true);
		}
		catch(e:Dynamic) { Assert.fail(e); }

		try{
			Appraiser.checkUnsetDirection(scenarioWriter.chapter, directionMap);
			Assert.isTrue(true);
		}
		catch(e:Dynamic) { Assert.fail(e); }

		try{
			Appraiser.checkUnsetEventIdInAreaMap(scenarioWriter.chapter, areaManager);
			Assert.isTrue(true);
		}
		catch(e:Dynamic) { Assert.fail(e); }

		try{
			Appraiser.checkSkipDirectionInAllAction(scenarioWriter.chapter, directionMap);
			Assert.isTrue(true);
		}
		catch(e:Dynamic) { Assert.fail(e); }
	}

	@Test
	public function testStory():Void
	{
		scenarioWriter = new Writer(items, inventory, directionMap, eventAreas, areaManager, actions, interactions);

	}
}