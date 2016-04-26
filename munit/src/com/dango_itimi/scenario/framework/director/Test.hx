package com.dango_itimi.scenario.framework.director;

import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.direction.Action;
import com.dango_itimi.scenario.framework.direction.Interaction;
import com.dango_itimi.scenario.framework.direction.Cut;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.geom.Point;
import com.dango_itimi.geom.Rectangle;
import com.dango_itimi.scenario.framework.area.AreaManager;
import massive.munit.Assert;

using com.dango_itimi.utils.MetaUtil;
using com.dango_itimi.scenario.core.Sequence;

class Test
{
	@rect(0) public var tableHitArea:Rectangle;
	@rect(1) public var bedHitArea:Rectangle;
	private static var TABLE_POSITION = PointUtil.create(0, 0);
	private static var BED_POSITION = PointUtil.create(2, 0);
	private static var OUT_POSITION = PointUtil.create(0, 2);

	private var inventory:Inventory;
	private var directionMap:DirectionMap;
	private var areaManager:AreaManager;
	private var director:Director;

	public function new()
	{
	}

	@BeforeClass
	public function beforeClass():Void
	{
		var metaFieldSet = this.getMetaFieldsWithInstance("rect");
		for(metaField in metaFieldSet)
		{
			var rectangle = RectangleUtil.create(metaField.value[0] * 2, 0, 1, 1);
			Reflect.setProperty(this, metaField.name, rectangle);
		}
	}

	@AfterClass
	public function afterClass():Void
	{
	}

	@Before
	public function setup():Void
	{
		inventory = new Inventory();
		directionMap = new DirectionMap();
		areaManager = new AreaManager();
		director = new Director(inventory, directionMap, areaManager);
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function test():Void
	{
		//setting
		var chapter = new Chapter();
		areaManager.register(chapter);

		var sword = new Item("");
		var shield = new Item("");

		var cut = new Cut(new Interaction(), new Action());
		var itemChangeCut = new ItemChangeCut(
			ItemChange.PICKED_UP([shield, sword]), new Interaction(), new Action()
		);

		var firedFilm = new FiredFilm(cut);
		var checkedFilm = new CheckedFilm(cut);
		var equipedIncorrectItemFilm = new EquipedIncorrectItemFilm(cut, sword, 0);
		var itemChangeFiredFilm = new FiredFilm(itemChangeCut);

		chapter.scene1.apple.enable();
		chapter.scene1.apple.enabledEventsAfterCompletion = [chapter.scene1.orange];
		areaManager.set(tableHitArea, chapter.scene1.apple);
		directionMap.set(chapter.scene1.apple, firedFilm);

		chapter.scene1.orange.requiredCompletionEvents = [chapter.scene1.apple];
		chapter.scene1.orange.enabledEventsAfterCompletion = [chapter.scene1.banana];
		areaManager.set(bedHitArea, chapter.scene1.orange);
		directionMap.set(chapter.scene1.orange, itemChangeFiredFilm);

		chapter.scene1.banana.requiredCompletionEvents = [chapter.scene1.orange, shield];
		areaManager.set(bedHitArea, chapter.scene1.banana);
		directionMap.set(chapter.scene1.banana, firedFilm, equipedIncorrectItemFilm);

		//test
		Assert.isTrue(chapter.checkOnlyEnabledEventSet([chapter.scene1.apple]));

		var film:Film;

		Assert.isFalse(Scenario.hasProgressEvent(areaManager, chapter.scene1, OUT_POSITION));
		film = director.progress(chapter.scene1, OUT_POSITION);
		Assert.isTrue(film == null);

		Assert.isTrue(Scenario.hasProgressEvent(areaManager, chapter.scene1, TABLE_POSITION));
		film = director.progress(chapter.scene1, TABLE_POSITION);
		Assert.isTrue(film == firedFilm);
		Assert.isTrue(chapter.checkOnlyEnabledEventSet([chapter.scene1.orange]));

		film = director.progress(chapter.scene1, BED_POSITION);
		Assert.isTrue(film == itemChangeFiredFilm);
		Assert.isTrue(chapter.checkOnlyEnabledEventSet([chapter.scene1.banana]));

		inventory.pickup(sword);
		inventory.select(sword);
		film = director.progress(chapter.scene1, BED_POSITION);
		Assert.isTrue(film == equipedIncorrectItemFilm);

		inventory.pickup(shield);
		inventory.select(shield);
		film = director.progress(chapter.scene1, BED_POSITION);
		Assert.isTrue(film == firedFilm);
	}
}
