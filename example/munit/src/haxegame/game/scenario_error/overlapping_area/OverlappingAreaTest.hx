package haxegame.game.scenario_error.overlapping_area;

import haxegame.game.scenario_error.overlapping_area.Story.Story1;
import haxegame.game.scenario_error.overlapping_area.Novel;
import massive.munit.Assert;

class OverlappingAreaTest
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
		var novel = new Novel();

		var story = new Story1();
		story.writtenNote = novel.note1;
		story.write();

		try{
			novel.checkSettingError();
			Assert.isTrue(false);
		}
		catch(error:String){
			trace(error);
			Assert.isTrue(true);
		}
	}
}
