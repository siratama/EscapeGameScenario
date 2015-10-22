package haxegame.game.scenario.story;

import haxegame.game.scenario.Novel.Note2;
class Story2 extends Story
{
	private var note:Note2;
	override public function write()
	{
		note = cast writtenNote;

		note.setAreaMap(note.table, eventAreaSprite.table);
		note.setAreaMap(note.mirror, eventAreaSprite.bed);

		note.setAreaMap(note.box, eventAreaSprite.bed);
		note.box.requiredFinishEvents = [note.table, note.mirror];
	}
}
