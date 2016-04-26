package com.dango_itimi.scenario.framework.areamap;

import com.dango_itimi.scenario.framework.Appraiser;
import com.dango_itimi.geom.Rectangle.RectangleUtil;
import com.dango_itimi.scenario.framework.area.AreaManager;
import massive.munit.Assert;

class Test
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
	public function testDuplicateRegistration():Void
	{
		var areaManager = new AreaManager();
		var chapter = new Chapter();
		areaManager.register(chapter);

		var hitArea = RectangleUtil.create(0, 0, 1, 1);

		areaManager.set(hitArea, chapter.scene1.apple);
		try{
			areaManager.set(hitArea, chapter.scene1.apple);
			Assert.isTrue(false);
		}
		catch(e:Dynamic){
			Assert.isTrue(true);
		}
	}

	@Test
	public function testUnsetHitArea():Void
	{
		var areaManager = new AreaManager();

		var chapter = new Chapter();
		areaManager.register(chapter);

		try{
			Appraiser.checkUnsetEventIdInAreaMap(chapter, areaManager);
			Assert.isTrue(false);
		}
		catch(e:Dynamic)
		{
			Assert.isTrue(true);
		}

		var hitArea = RectangleUtil.create(0, 0, 1, 1);
		areaManager.set(hitArea, chapter.scene1.apple);
		try{
			Appraiser.checkUnsetEventIdInAreaMap(chapter, areaManager);
			Assert.isTrue(true);
		}
		catch(e:Dynamic)
		{
			Assert.isTrue(false);
		}
	}
}
