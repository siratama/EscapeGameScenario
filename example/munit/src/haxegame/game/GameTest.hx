package haxegame.game;

import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.item.ItemHolder;
import haxegame.game.scenario.Writer;
import haxegame.game.scenario.Chapter;
import com.dango_itimi.scenario.core.Scenario;
import com.dango_itimi.geom.Point;
import massive.munit.Assert;

using com.dango_itimi.geom.Point.PointUtil;

class GameTest
{
	private var itemHolder:ItemHolder;
	private var directionMap:DirectionMap;
	private var eventAreaSprite:EventAreaSprite;

	private var writer:Writer;
	private var chapter:Chapter;

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
		itemHolder = new ItemHolder();
		directionMap = new DirectionMap();
		eventAreaSprite = new EventAreaSprite();

		writer = new Writer(itemHolder, directionMap, eventAreaSprite);
		chapter = writer.chapter;
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function testBranchStoryIsNotFired():Void
	{
		/*
		Assert.isFalse(reader.isProgressEventExisted(OUT_POSITION));
		Assert.isTrue(reader.isProgressEventExisted(TABLE_POSITION));

		reader.progress(TABLE_POSITION);
		Assert.isFalse(novel.note2.table.finished);
		Assert.isFalse(novel.note3.table.finished);
		Assert.isTrue(novel.note1.table.finished);
		*/
	}

	/*
	@Test
	public function testStory():Void
	{
		testStory1();
		testStory2();
		testStoryExchange();
	}
	private function testStory1():Void
	{
		//bed unfinished all required events
		switch(reader.progress(BED_POSITION)[0].progress){
			case Progress.MISFIRED(event, misfired, itemLack, unfinishedAllRequiredEvents):
				Assert.areEqual(event, novel.note1.bed);
				Assert.isTrue(!misfired && !itemLack && unfinishedAllRequiredEvents);
			case _: Assert.isTrue(false);
		}

		//out position
		switch(reader.progress(OUT_POSITION)[0].progress){
			case Progress.NO_HITAREA: Assert.isTrue(true);
			case _: Assert.isTrue(false);
		}

		//table fire
		switch(reader.progress(TABLE_POSITION)[0].progress){
			case Progress.NEXT(event):
				Assert.areEqual(event, novel.note1.table);
				Assert.isTrue(novel.note1.table.finished);
			case _: Assert.isTrue(false);
		}

		//bed fire
		switch(reader.progress(BED_POSITION)[0].progress){
			case Progress.NEXT(event): Assert.areEqual(event, novel.note1.bed);
			case _: Assert.isTrue(false);
		}

		//box is lacked item
		switch(reader.progress(TABLE_POSITION)[0].progress){
			case Progress.MISFIRED(event, misfired, itemLack, unfinishedAllRequiredEvents):
				Assert.areEqual(event, novel.note1.box);
				Assert.isTrue(!misfired && itemLack && !unfinishedAllRequiredEvents);
			case _: Assert.isTrue(false);
		}

		//floor fire
		switch(reader.progress(BED_POSITION)[0].progress){
			case Progress.NEXT(event):
				Assert.areEqual(event, novel.note1.floor);

				itemHolder.changeItems(event);
				Assert.areEqual(itemHolder.set.length, 1);
				Assert.areEqual(itemHolder.set[0], gameItems.normalShield);
			case _: Assert.isTrue(false);
		}

		//box fire
		switch(reader.progress(TABLE_POSITION)[0].progress){
			case Progress.NEXT(event):
				Assert.areEqual(event, novel.note1.box);

				itemHolder.changeItems(event);
				Assert.areEqual(itemHolder.set.length, 1);
				Assert.areEqual(itemHolder.set[0], gameItems.normalSword);
			case _: Assert.isTrue(false);
		}
	}
	private function testStory2()
	{
		//auto branch to story2
		Assert.areEqual(novel.readingNotes[0], novel.note2);

		//mirror
		switch(reader.progress(BED_POSITION)[0].progress){
			case Progress.NEXT(event): Assert.areEqual(event, novel.note2.mirror);
			case _: Assert.isTrue(false);
		}

		//table
		switch(reader.progress(TABLE_POSITION)[0].progress){
			case Progress.NEXT(event): Assert.areEqual(event, novel.note2.table);
			case _: Assert.isTrue(false);
		}
	}
	private function testStoryExchange()
	{
		//exchange to story3
		novel.exchangeReadingNote(novel.note2, novel.note3);

		//story3 table fire
		switch(reader.progress(TABLE_POSITION)[0].progress){
			case Progress.NEXT(event): Assert.areEqual(event, novel.note3.table);
			case _: Assert.isTrue(false);
		}

		//exchange to story2
		novel.exchangeReadingNote(novel.note3, novel.note2);

		//story2 box fire
		switch(reader.progress(BED_POSITION)[0].progress){
			case Progress.NEXT(event): Assert.areEqual(event, novel.note2.box);
			case _: Assert.isTrue(false);
		}
	}
	*/
}
