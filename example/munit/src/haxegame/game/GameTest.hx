package haxegame.game;

import com.dango_itimi.scenario.framework.Assistant;
import com.dango_itimi.scenario.framework.Projector;
import com.dango_itimi.scenario.framework.Director;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.item.Inventory;
import haxegame.game.scenario.Writer;
import haxegame.game.scenario.Chapter;
import com.dango_itimi.geom.Point;
import massive.munit.Assert;

using com.dango_itimi.geom.Point.PointUtil;

class GameTest
{
	private var itemHolder:Inventory;
	private var directionMap:DirectionMap;
	private var eventAreaSprite:EventAreaSprite;

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
		itemHolder = new Inventory();
		directionMap = new DirectionMap();
		eventAreaSprite = new EventAreaSprite();

		scenarioWriter = new Writer(itemHolder, directionMap, eventAreaSprite);
		chapter = scenarioWriter.chapter;

		subtitle = new Subtitle();
		projector = new Projector(itemHolder, subtitle.textViewer);
		director = new Director(projector, itemHolder, directionMap);
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function testPairOfEventAndDirection():Void
	{
		try{
			Assistant.checkError(chapter, directionMap);
		}
		catch(e:Dynamic)
		{
			Assert.fail(e);
		}

		director.progress(chapter.scene1, TABLE_POSITION);
		trace("aaa");

		/*
		Assert.isFalse(reader.isProgressEventExisted(OUT_POSITION));
		Assert.isTrue(reader.isProgressEventExisted(TABLE_POSITION));

		reader.progress(TABLE_POSITION);
		Assert.isFalse(novel.note2.table.finished);
		Assert.isFalse(novel.note3.table.finished);
		Assert.isTrue(novel.note1.table.finished);
		*/
	}

	@Test
	public function testStory():Void
	{
		trace("check");
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
