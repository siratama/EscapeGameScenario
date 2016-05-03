package com.dango_itimi.scenario.framework.projector;

import massive.munit.Assert;
import com.dango_itimi.scenario.framework.direction.interaction.Interaction;
import com.dango_itimi.scenario.framework.direction.action.Sleep;
import com.dango_itimi.scenario.framework.text.Subtitle;
import com.dango_itimi.scenario.framework.direction.interaction.ClickOperation;
import com.dango_itimi.scenario.framework.Projector;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.direction.action.Action;
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
	private var projector:Projector;
	private var textViewer:Subtitle;

	private var chapter:Chapter;
	private var items:Items;
	private var clickChecker:ClickOperation;
	private var cut:Cut;
	private var sleepCut:Cut;
	private var itemPickedUpCut:ItemChangeCut;
	private var itemRemovedCut:ItemChangeCut;
	private var itemExchangedCut:ItemChangeCut;

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

		textViewer = new Subtitle(0, 0);
		projector = new Projector(textViewer);

		chapter = new Chapter();
		areaManager.register(chapter);
		items = new Items();

		clickChecker = new ClickOperation();

		cut = new Cut(clickChecker, new Action());
		sleepCut = new Cut(clickChecker, new Interaction(), new Sleep(60));

		itemPickedUpCut = new ItemChangeCut(
			ItemChange.PICKED_UP([items.shield, items.sword]), clickChecker, new Action()
		);
		itemRemovedCut = new ItemChangeCut(
			ItemChange.REMOVED([items.shield]), clickChecker, new Action()
		);
		itemExchangedCut = new ItemChangeCut(
			ItemChange.EXCHANGED([items.shield],[items.sword]), clickChecker, new Action()
		);
	}

	@After
	public function tearDown():Void
	{
	}

	private function playProjector(film:Film, ?skipDirection:Bool = false, ?count:Int = 1000)
	{
		projector.initialize(film);

		while(count > 0)
		{
			projector.run();
			if(projector.isPlaying() && Std.is(projector.displayCut.skipOperation, ClickOperation) && skipDirection)
				cast(projector.displayCut.skipOperation, ClickOperation).clicked = true;

			else if(projector.isWaitingClapperboard())
				cast(projector.displayCut.clapperboard, ClickOperation).clicked = true;

			switch(projector.getEvent())
			{
				case ProjectorEvent.NONE: "";
				case ProjectorEvent.CUT_START(cutStart):
					switch(cutStart)
					{
						case CutStart.NONE: "";
						case CutStart.ITEM_CHANGE(itemChange): inventory.change(itemChange);
						case CutStart.EQUIPED_INCORRECT_ITEM(item): "";
					}
				case ProjectorEvent.FINISH: break;
			}
			count--;
		}
		if(count == 0){
			Assert.fail("projector infinite roop");
		}
	}

	@Test
	public function testSingleCut():Void
	{
		var firedFilm = new FiredFilm(cut);
		var checkedFilm = new CheckedFilm(cut);
		var equipedIncorrectItemFilm = new EquipedIncorrectItemFilm(cut, items.sword, 0);

		playProjector(firedFilm);
		playProjector(checkedFilm);
		playProjector(equipedIncorrectItemFilm);
	}

	@Test
	public function testCuts():Void
	{
		var firedFilm = new FiredFilm(cut);
		firedFilm.add(sleepCut);
		firedFilm.add(cut);

		var checkedFilm = new CheckedFilm(cut);
		checkedFilm.add(sleepCut);
		checkedFilm.add(cut);

		var equipedIncorrectItemFilm = new EquipedIncorrectItemFilm(cut, items.sword, 0);
		equipedIncorrectItemFilm.add(sleepCut);
		equipedIncorrectItemFilm.add(cut);

		playProjector(firedFilm);
		playProjector(checkedFilm);
		playProjector(equipedIncorrectItemFilm);
	}

	@Test
	public function testChangedInventory():Void
	{
		var itemPickedUpFilm = new FiredFilm(itemPickedUpCut);
		var itemRemovedFilm = new FiredFilm(itemRemovedCut);
		var itemExchangedFilm = new FiredFilm(itemExchangedCut);

		try{
			playProjector(itemRemovedFilm);
			Assert.isTrue(false);
		}catch(e:Dynamic){
			Assert.isTrue(true);
		}

		playProjector(itemPickedUpFilm);
		Assert.isTrue(inventory.set.length == 2);

		playProjector(itemRemovedFilm);
		Assert.isTrue(inventory.set.length == 1);
		Assert.isTrue(inventory.set[0] == items.sword);

		playProjector(itemExchangedFilm);
		Assert.isTrue(inventory.set.length == 1);
		Assert.isTrue(inventory.set[0] == items.shield);
	}
}
