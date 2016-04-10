package haxegame.game.scenario.story;

import haxegame.game.scenario.Chapter.Note3;
class Story3 extends Episode
{
	private var note:Note3;
	override public function write()
	{
		note = cast writtenNote;

		note.setAreaMap(note.table, eventAreaSprite.table);

		note.setAreaMap(note.box, eventAreaSprite.bed);
		note.box.requiredFinishEvents = [note.table];
	}
}
