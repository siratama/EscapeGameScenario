package haxegame.game.event;

import com.dango_itimi.escape_game.ItemHolder;
import haxegame.game.item.GameItems;
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
	private var checkPosition:Point;

	private static inline var OUT_POSITION_Y = 2;
	private static inline var HIT_POSITION_Y = 0;
	private static inline var BED_POSITION_X = 2;

	public function new()
	{

	}

	@BeforeClass
	public function beforeClass():Void
	{
		gameBook = new GameBook();
		bookReader = new BookReader(gameBook);
		gameItems = GameItems.instance;
	}

	@AfterClass
	public function afterClass():Void
	{
	}

	@Before
	public function setup():Void
	{
		itemHolder = new ItemHolder();
		checkPosition = PointUtil.create(0, 0);
	}

	@After
	public function tearDown():Void
	{
	}


	@Test
	public function testBedIsNotFired():Void
	{
		//bed
		checkPosition.x = BED_POSITION_X;
		var firedEvent = bookReader.progress(checkPosition, itemHolder.set);
		Assert.isNull(firedEvent);
	}

	@Test
	public function testExample():Void
	{
		//table
		checkPosition.y = OUT_POSITION_Y;
		var firedEvent = bookReader.progress(checkPosition, itemHolder.set);
		Assert.isNull(firedEvent);

		checkPosition.y = HIT_POSITION_Y;
		var firedEvent = bookReader.progress(checkPosition, itemHolder.set);
		Assert.isNotNull(firedEvent);

		Assert.areEqual(firedEvent, gameBook.story1.table);
		Assert.isTrue(gameBook.story1.table.finished);

		//bed
		checkPosition.x = BED_POSITION_X;
		var firedEvent = bookReader.progress(checkPosition, itemHolder.set);
		Assert.isNotNull(firedEvent);

		Assert.areEqual(firedEvent, gameBook.story1.bed);
		Assert.isTrue(gameBook.story1.bed.finished);

		//floor
		var firedEvent = bookReader.progress(checkPosition, itemHolder.set);
		Assert.isNotNull(firedEvent);
		Assert.areEqual(firedEvent, gameBook.story1.floor);
		Assert.isTrue(gameBook.story1.floor.finished);
		changeItems(firedEvent);

		Assert.areEqual(itemHolder.set.length, 1);
		Assert.areEqual(itemHolder.set[0], gameItems.normalSield);
	}
	private function changeItems(firedEvent:Event)
	{
		if(firedEvent.removedItems != null)
			itemHolder.removeItems(firedEvent.removedItems);

		if(firedEvent.gottenItems != null)
			itemHolder.addItems(firedEvent.gottenItems);
	}
}
