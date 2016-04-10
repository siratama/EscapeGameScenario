package haxegame.game.scenario.story;

import haxegame.game.scenario.EventOption.EventOptionCreator;
import haxegame.game.scenario.EventOption.Texts;
import haxegame.game.scenario.Chapter.Note1;

class Story1 extends Episode
{
	private var note:Note1;

	override public function write()
	{
		note = cast writtenNote;

		setTable();
		setBed();
		setFloor();
		setBox();
		setWindow();
	}
	private function setTable()
	{
		note.setAreaMap(note.table, eventAreaSprite.table);

		var texts = new Texts();
		texts.fired = ["The table is broken."];
		directionMap[note.table] = EventOptionCreator.create(texts);
	}
	private function setBed()
	{
		note.setAreaMap(note.bed, eventAreaSprite.bed);
		note.bed.requiredFinishEvents = [note.table];

		var texts = new Texts();
		texts.checked = ["This is a bed."];
		texts.fired = ["The floor is broken."];
		directionMap[note.bed] = EventOptionCreator.create(texts);
	}
	private function setFloor()
	{
		note.setAreaMap(note.floor, eventAreaSprite.bed);
		note.floor.requiredFinishEvents = [note.bed];
		note.floor.gottenItems = [items.normalShield];
	}
	private function setBox()
	{
		note.setAreaMap(note.box, eventAreaSprite.table);
		note.box.requiredFinishEvents = [note.bed];
		note.box.requiredItems = [items.normalShield];
		note.box.removedItems = [items.normalShield];
		note.box.gottenItems = [items.normalSword];
	}
	private function setWindow()
	{
		note.setAreaMap(note.window, eventAreaSprite.table);
		note.window.misfired = true;
	}
}
