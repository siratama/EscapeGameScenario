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

class MultiProgressTest
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
		writer = new WriterB();
		novel = writer.novel;
		itemHolder = new ItemHolder();
		reader = new Reader(novel, itemHolder);
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function testStory():Void
	{
		var progressPropertySet = reader.progress(TABLE_POSITION);
		Assert.isTrue(progressPropertySet.length == 2);

		//table fire
		for (i in 0...progressPropertySet.length)
		{
			var progressProperty = progressPropertySet[i];
			if(progressProperty.readingNote == novel.note1)
			{
				switch(progressProperty.progress){
					case Progress.NEXT(event):
						Assert.areEqual(event, novel.note1.table);
						Assert.isTrue(novel.note1.table.finished);
					case _: Assert.isTrue(false);
				}
			}
			else if(progressProperty.readingNote == novel.note4)
			{
				switch(progressProperty.progress){
					case Progress.NEXT(event):
						Assert.areEqual(event, novel.note4.entrance);
						Assert.isTrue(novel.note4.entrance.finished);
					case _: Assert.isTrue(false);
				}
			}
			else{
				Assert.isTrue(false);
			}
		}
	}
}
