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
		//testStory2();
		//testStoryExchange();
	}
	private function testStory1():Void
	{
		//bed
		switch(bookReader.progress(BED_POSITION)){
			case Progress.UNFIRED(event, unfired, itemLack, unfinishedAllRequiredEvents):
				Assert.areEqual(event, gameBook.story1.bed);
				Assert.isTrue(!unfired && !itemLack && unfinishedAllRequiredEvents);
			case _: Assert.isTrue(false);
		}


		/*
		switch(progress){
			case Progress.UNFIRED(event, unfired, itemLack, unfinishedAllRequiredEvents):
				Assert.areEqual(event, gameBook.story1.bed);
				Assert.isTrue(!unfired && !itemLack && unfinishedAllRequiredEvents);
			case _: Assert.isTrue(false);
		}
		*/

		//Assert.areEqual(progress, Progress.UNFIRED)

		/*
		//table
		var progress = bookReader.progress(OUT_POSITION);
		Assert.isNull(progress);

		var progress = bookReader.progress(TABLE_POSITION);
		Assert.isNotNull(progress);
		Assert.areEqual(progress, gameBook.story1.table);
		Assert.isTrue(gameBook.story1.table.finished);

		//bed
		var progress = bookReader.progress(BED_POSITION);
		Assert.isNotNull(progress);
		Assert.areEqual(progress, gameBook.story1.bed);
		Assert.isTrue(gameBook.story1.bed.finished);

		//box
		var progress = bookReader.progress(TABLE_POSITION);
		Assert.isNull(progress);

		//floor
		var progress = bookReader.progress(BED_POSITION);
		Assert.isNotNull(progress);
		Assert.areEqual(progress, gameBook.story1.floor);
		Assert.isTrue(gameBook.story1.floor.finished);
		itemHolder.changeItems(progress);
		Assert.areEqual(itemHolder.set.length, 1);
		Assert.areEqual(itemHolder.set[0], gameItems.normalShield);

		//box
		var progress = bookReader.progress(TABLE_POSITION);
		Assert.areEqual(progress, gameBook.story1.box);
		Assert.isTrue(gameBook.story1.box.finished);
		itemHolder.changeItems(progress);
		Assert.areEqual(itemHolder.set.length, 1);
		Assert.areEqual(itemHolder.set[0], gameItems.normalSword);
		*/
	}
	/*
	private function testStory2()
	{
		//
		//branch
		//
		Assert.areEqual(gameBook.readingStory, gameBook.story2);

		//mirror
		var progress = bookReader.progress(BED_POSITION);
		Assert.areEqual(progress, gameBook.story2.mirror);

		//table
		var progress = bookReader.progress(TABLE_POSITION);
		Assert.areEqual(progress, gameBook.story2.table);
	}
	private function testStoryExchange()
	{
		//
		//exchange to story3
		//
		gameBook.exchangeReadingStory(gameBook.story3);

		//story2 box
		var progress = bookReader.progress(BED_POSITION);
		Assert.isNull(progress);

		//story3 table
		var progress = bookReader.progress(TABLE_POSITION);
		Assert.areEqual(progress, gameBook.story3.table);

		//
		//exchange to story2
		//
		gameBook.exchangeReadingStory(gameBook.story2);

		//story2 box
		var progress = bookReader.progress(BED_POSITION);
		Assert.areEqual(progress, gameBook.story2.box);

		//story3 box
		var progress = bookReader.progress(BED_POSITION);
		Assert.isNull(progress);
	}
	*/
}
