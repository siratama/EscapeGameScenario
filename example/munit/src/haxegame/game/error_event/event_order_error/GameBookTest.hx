package haxegame.game.error_event.event_order_error;

import massive.munit.Assert;

class GameBookTest
{
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
	}

	@After
	public function tearDown():Void
	{
	}


	@Test
	public function testOverlappingArea():Void
	{
		try{
			var gameBook = new GameBook();
			Assert.isTrue(false);
		}
		catch(error:String){
			trace(error);
			Assert.isTrue(true);
		}
	}
}
