package haxegame.game;

import haxegame.game.scenario.Writer;
import haxegame.game.scenario.Novel;
import haxegame.game.item.GameItems;
import com.dango_itimi.escape_game.ItemHolder;
import com.dango_itimi.escape_game.book.Event;
import com.dango_itimi.geom.Point;
import com.dango_itimi.escape_game.Reader;
import massive.munit.Assert;

using com.dango_itimi.geom.Point.PointUtil;

class SingleProgressTest
{
	private var writer:Writer;
	private var novel:Novel;
	private var itemHolder:ItemHolder;
	private var gameItems:GameItems;
	private var reader:Reader;

	private static var TABLE_POSITION = PointUtil.create(0, 0);
	private static var BED_POSITION = PointUtil.create(2, 0);
	private static var OUT_POSITION = PointUtil.create(0, 2);

	public function new()
	{

	}

	@BeforeClass
	public function beforeClass():Void
	{
		gameItems = GameItems.instance;
	}

	@AfterClass
	public function afterClass():Void
	{
	}

	@Before
	public function setup():Void
	{
		writer = new SingleProgressWriter();
		novel = writer.novel;
		itemHolder = new ItemHolder();
		reader = new Reader(novel, itemHolder);
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function testBranchStoryIsNotFired():Void
	{
		Assert.isFalse(reader.isProgressEventExisted(OUT_POSITION));
		Assert.isTrue(reader.isProgressEventExisted(TABLE_POSITION));

		reader.progress(TABLE_POSITION);
		Assert.isFalse(novel.note2.table.finished);
		Assert.isFalse(novel.note3.table.finished);
		Assert.isTrue(novel.note1.table.finished);
	}

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
}
