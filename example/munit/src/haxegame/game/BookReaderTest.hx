package haxegame.game;

import haxegame.game.event.GameBook;
import haxegame.game.item.GameItems;
import com.dango_itimi.escape_game.ItemHolder;
import com.dango_itimi.escape_game.event.Event;
import com.dango_itimi.geom.Point;
import com.dango_itimi.escape_game.BookReader;
import massive.munit.Assert;

using com.dango_itimi.geom.Point.PointUtil;

class BookReaderTest
{
	private var gameBook:GameBook;
	private var itemHolder:ItemHolder;
	private var gameItems:GameItems;
	private var bookReader:BookReader;

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
		gameBook = new GameBook();
		itemHolder = new ItemHolder();
		bookReader = new BookReader(gameBook, itemHolder);
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function testBranchStoryIsNotFired():Void
	{
		bookReader.progress(TABLE_POSITION);
		Assert.isFalse(gameBook.story2.table.finished);
		Assert.isFalse(gameBook.story3.table.finished);
		Assert.isTrue(gameBook.story1.table.finished);
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
		switch(bookReader.progress(BED_POSITION)){
			case Progress.MISFIRED(event, misfired, itemLack, unfinishedAllRequiredEvents):
				Assert.areEqual(event, gameBook.story1.bed);
				Assert.isTrue(!misfired && !itemLack && unfinishedAllRequiredEvents);
			case _: Assert.isTrue(false);
		}

		//out position
		switch(bookReader.progress(OUT_POSITION)){
			case Progress.NO_HITAREA: Assert.isTrue(true);
			case _: Assert.isTrue(false);
		}

		//table fire
		switch(bookReader.progress(TABLE_POSITION)){
			case Progress.NEXT(event):
				Assert.areEqual(event, gameBook.story1.table);
				Assert.isTrue(gameBook.story1.table.finished);
			case _: Assert.isTrue(false);
		}

		//bed fire
		switch(bookReader.progress(BED_POSITION)){
			case Progress.NEXT(event): Assert.areEqual(event, gameBook.story1.bed);
			case _: Assert.isTrue(false);
		}

		//box is lacked item
		switch(bookReader.progress(TABLE_POSITION)){
			case Progress.MISFIRED(event, misfired, itemLack, unfinishedAllRequiredEvents):
				Assert.areEqual(event, gameBook.story1.box);
				Assert.isTrue(!misfired && itemLack && !unfinishedAllRequiredEvents);
			case _: Assert.isTrue(false);
		}

		//floor fire
		switch(bookReader.progress(BED_POSITION)){
			case Progress.NEXT(event):
				Assert.areEqual(event, gameBook.story1.floor);

				itemHolder.changeItems(event);
				Assert.areEqual(itemHolder.set.length, 1);
				Assert.areEqual(itemHolder.set[0], gameItems.normalShield);
			case _: Assert.isTrue(false);
		}

		//box fire
		switch(bookReader.progress(TABLE_POSITION)){
			case Progress.NEXT(event):
				Assert.areEqual(event, gameBook.story1.box);

				itemHolder.changeItems(event);
				Assert.areEqual(itemHolder.set.length, 1);
				Assert.areEqual(itemHolder.set[0], gameItems.normalSword);
			case _: Assert.isTrue(false);
		}
	}
	private function testStory2()
	{
		//auto branch to story2
		Assert.areEqual(gameBook.readingStory, gameBook.story2);

		//mirror
		switch(bookReader.progress(BED_POSITION)){
			case Progress.NEXT(event): Assert.areEqual(event, gameBook.story2.mirror);
			case _: Assert.isTrue(false);
		}

		//table
		switch(bookReader.progress(TABLE_POSITION)){
			case Progress.NEXT(event): Assert.areEqual(event, gameBook.story2.table);
			case _: Assert.isTrue(false);
		}
	}
	private function testStoryExchange()
	{
		//exchange to story3
		gameBook.exchangeReadingStory(gameBook.story3);

		//story3 table fire
		switch(bookReader.progress(TABLE_POSITION)){
			case Progress.NEXT(event): Assert.areEqual(event, gameBook.story3.table);
			case _: Assert.isTrue(false);
		}

		//exchange to story2
		gameBook.exchangeReadingStory(gameBook.story2);

		//story2 box fire
		switch(bookReader.progress(BED_POSITION)){
			case Progress.NEXT(event): Assert.areEqual(event, gameBook.story2.box);
			case _: Assert.isTrue(false);
		}
	}
}
