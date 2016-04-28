package com.dango_itimi.scenario.framework.save;

import haxe.Serializer;
import massive.munit.Assert;
import com.dango_itimi.scenario.framework.direction.interaction.Interaction;
import com.dango_itimi.scenario.framework.direction.action.Sleep;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.direction.action.Action;
import com.dango_itimi.scenario.framework.direction.Cut;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.item.Inventory;

using com.dango_itimi.utils.MetaUtil;
using com.dango_itimi.scenario.core.Sequence;

class Test
{
	private var inventory:Inventory;
	private var directionMap:DirectionMap;

	private var chapter:Chapter;
	private var items:Items;
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

		chapter = new Chapter();
		items = new Items();

		cut = new Cut(new Interaction(), new Action());
		sleepCut = new Cut(new Interaction(), new Interaction(), new Sleep(60));

		itemPickedUpCut = new ItemChangeCut(
			ItemChange.PICKED_UP([items.shield, items.sword]), new Interaction(), new Action()
		);
		itemRemovedCut = new ItemChangeCut(
			ItemChange.REMOVED([items.shield]), new Interaction(), new Action()
		);
		itemExchangedCut = new ItemChangeCut(
			ItemChange.EXCHANGED([items.shield],[items.sword]), new Interaction(), new Action()
		);
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function testSavedEventError():Void
	{
		var firedEventIdSet = [
			"dummy"
		];
		var loadedRecord:Record = {firedEventIdSet: firedEventIdSet};
		var serializedLoadedRecord = Serializer.run(loadedRecord);
		var recorder = new Recorder(serializedLoadedRecord);

		var eventMap = chapter.getEventMap();

		try{
			recorder.checkSavedEventNullError(eventMap);
			Assert.isTrue(false);
		}
		catch(e:Dynamic)
		{
			Assert.isTrue(true);
		}
	}

	@Test
	public function testSavedEventSuccess():Void
	{
		var firedEventIdSet = [
			chapter.scene1.apple.id,
			chapter.scene1.orange.id,
			chapter.scene1.banana.id
		];
		var loadedRecord:Record = {firedEventIdSet: firedEventIdSet};
		var serializedLoadedRecord = Serializer.run(loadedRecord);
		var recorder = new Recorder(serializedLoadedRecord);

		var eventMap = chapter.getEventMap();

		try{
			recorder.checkSavedEventNullError(eventMap);
			Assert.isTrue(true);
		}
		catch(e:Dynamic)
		{
			Assert.isTrue(false);
		}
	}

	@Test
	public function testRecordPlayer():Void
	{
		var firedEventIdSet = [
			chapter.scene1.apple.id,
			chapter.scene1.orange.id,
			chapter.scene1.banana.id,
			chapter.scene1.tomato.id,
			chapter.scene1.water.id
		];
		var loadedRecord:Record = {firedEventIdSet: firedEventIdSet};
		var serializedLoadedRecord = Serializer.run(loadedRecord);
		var recorder = new Recorder(serializedLoadedRecord);
		var eventMap = chapter.getEventMap();
		var eventSet = recorder.getRecordedEventSet(eventMap);

		//
		var firedFilm = new FiredFilm(cut);
		firedFilm.add(sleepCut);
		firedFilm.add(cut);

		var itemPickedUpFilm = new FiredFilm(itemPickedUpCut);
		itemPickedUpFilm.add(cut);

		var itemRemovedFilm = new FiredFilm(itemRemovedCut);
		var itemExchangedFilm = new FiredFilm(itemExchangedCut);

		directionMap.set(chapter.scene1.apple, firedFilm);
		directionMap.set(chapter.scene1.orange, itemPickedUpFilm);
		directionMap.set(chapter.scene1.banana, itemRemovedFilm);
		directionMap.set(chapter.scene1.tomato, itemExchangedFilm);
		directionMap.set(chapter.scene1.water, firedFilm);

		RecordPlayer.play(eventSet, inventory, directionMap);
		Assert.isTrue(inventory.set.length == 1);
		Assert.isTrue(inventory.set[0] == items.shield);
	}
}
