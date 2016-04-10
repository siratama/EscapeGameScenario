package haxegame.game.scenario.story;
import haxegame.game.scenario.Chapter.Note4;
class Story4 extends Episode
{
	private var note:Note4;
	override public function write()
	{
		note = cast writtenNote;

		note.setAreaMap(note.entrance, eventAreaSprite.table);
	}
}
