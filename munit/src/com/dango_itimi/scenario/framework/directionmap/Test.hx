package com.dango_itimi.scenario.framework.directionmap;

import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.Appraiser;
import com.dango_itimi.scenario.framework.direction.Interaction;
import com.dango_itimi.scenario.framework.direction.Action;
import com.dango_itimi.scenario.framework.direction.Cut;
import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import massive.munit.Assert;

class Test
{
	private var directionMap:DirectionMap;
	private var chapter:Chapter;

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
		directionMap = new DirectionMap();
		chapter = new Chapter();
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function testDuplicateRegistration():Void
	{
		var cut = new Cut(
			new Interaction(),
			new Action()
		);
		var firedFilm = new FiredFilm(cut);
		directionMap.set(chapter.scene1.apple, firedFilm);

		try{
			directionMap.set(chapter.scene1.apple, firedFilm);
			Assert.isTrue(false);
		}
		catch(e:Dynamic){
			Assert.isTrue(true);
		}
	}

	@Test
	public function testUnsetDirection():Void
	{
		try{
			Appraiser.checkUnsetDirection(chapter, directionMap);
			Assert.isTrue(false);
		}
		catch(e:Dynamic){
			Assert.isTrue(true);
		}

		var cut = new Cut(
			new Interaction(),
			new Action()
		);
		var firedFilm = new FiredFilm(cut);
		directionMap.set(chapter.scene1.apple, firedFilm);

		try{
			Appraiser.checkUnsetDirection(chapter, directionMap);
			Assert.isTrue(true);
		}
		catch(e:Dynamic){
			Assert.isTrue(false);
		}
	}

	@Test
	public function testFiredFilmRegistration():Void
	{
		var cut = new Cut(
			new Interaction(),
			new Action()
		);
		var firedFilm = new FiredFilm(cut);
		try{
			directionMap.set(chapter.scene1.apple, firedFilm);
			Assert.isTrue(true);
		}
		catch(e:Dynamic){
			Assert.isTrue(false);
		}
	}
	@Test
	public function testCheckedFilmRegistration():Void
	{
		var cut = new Cut(
			new Interaction(),
			new Action()
		);
		var film = new CheckedFilm(cut);
		try{
			directionMap.set(chapter.scene1.apple, film);
			Assert.isTrue(true);
		}
		catch(e:Dynamic){
			Assert.isTrue(false);
		}
	}
	@Test
	public function testEquipedIncorrectItemFilmRegistration():Void
	{
		var cut = new Cut(
			new Interaction(),
			new Action()
		);
		var sword = new Item("");
		var equipedIncorrectItemFilm = new EquipedIncorrectItemFilm(cut, sword, 0);
		try{
			directionMap.set(chapter.scene1.apple, equipedIncorrectItemFilm);
			Assert.isTrue(false);
		}
		catch(e:Dynamic){
			Assert.isTrue(true);
		}

		var firedFilm = new FiredFilm(cut);
		try{
			directionMap.set(chapter.scene1.apple, firedFilm, equipedIncorrectItemFilm);
			Assert.isTrue(false);
		}
		catch(e:Dynamic){
			Assert.isTrue(true);
		}

		var shield = new Item("");
		chapter.scene1.apple.requiredCompletionEvents = [shield];
		try{
			directionMap.set(chapter.scene1.apple, firedFilm, equipedIncorrectItemFilm);
			Assert.isTrue(true);
		}
		catch(e:Dynamic){
			Assert.isTrue(false);
		}
	}

	@Test
	public function testUnsetRequireCompletionItemOfEquipedIncorrectItemFilmRegistration():Void
	{
		var cut = new Cut(
			new Interaction(),
			new Action()
		);
		var firedFilm = new FiredFilm(cut);

		var item = new Item("");
		var equipedIncorrectItemFilm = new EquipedIncorrectItemFilm(cut, item, 0);

		try{
			directionMap.set(chapter.scene1.apple, firedFilm, equipedIncorrectItemFilm);
			Assert.isTrue(false);
		}
		catch(e:Dynamic){
			Assert.isTrue(true);
		}

		var itemB = new Item("");
		chapter.scene1.apple.requiredCompletionEvents = [itemB];

		try{
			directionMap.set(chapter.scene1.apple, firedFilm, equipedIncorrectItemFilm);
			Assert.isTrue(true);
		}
		catch(e:Dynamic){
			Assert.isTrue(false);
		}
	}

	@Test
	public function testSkipDirectionInAllActionError():Void
	{
		var chapterB = new ChapterB();

		var cut = new Cut(new Interaction(), new EndlessAction());
		var firedFilm = new FiredFilm(cut);
		firedFilm.add(cut);

		var checkedFilm = new CheckedFilm(cut);

		var equipedIncorrectItemFilm = new EquipedIncorrectItemFilm(cut, new Item(""), 1);
		equipedIncorrectItemFilm.add(cut);

		chapterB.sceneB1.apple.requiredCompletionEvents = [new Item("")];
		directionMap.set(chapterB.sceneB1.apple, firedFilm, checkedFilm, equipedIncorrectItemFilm);

		directionMap.set(chapterB.sceneB1.orange, firedFilm);
		directionMap.set(chapterB.sceneB1.banana, firedFilm);

		try{
			Appraiser.checkSkipDirectionInAllAction(chapterB, directionMap);
			Assert.isTrue(false);
		}
		catch(e:Dynamic){
			Assert.isTrue(true);
		}
	}

	@Test
	public function testSkipDirectionInAllActionSuccess():Void
	{
		var chapterB = new ChapterB();

		var cut = new Cut(new Interaction(), new Action());
		var firedFilm = new FiredFilm(cut);
		firedFilm.add(cut);
		firedFilm.add(cut);

		var checkedFilm = new CheckedFilm(cut);

		var equipedIncorrectItemFilm = new EquipedIncorrectItemFilm(cut, new Item(""), 1);
		equipedIncorrectItemFilm.add(cut);

		chapterB.sceneB1.apple.requiredCompletionEvents = [new Item("")];

		directionMap.set(chapterB.sceneB1.apple, firedFilm, checkedFilm, equipedIncorrectItemFilm);
		directionMap.set(chapterB.sceneB1.orange, firedFilm);
		directionMap.set(chapterB.sceneB1.banana, firedFilm);

		try{
			Appraiser.checkSkipDirectionInAllAction(chapterB, directionMap);
			Assert.isTrue(true);
		}
		catch(e:Dynamic){
			Assert.isTrue(false);
		}
	}
}
