package haxegame.game.scenario.story;
import haxegame.game.scenario.Novel.Note4;
class Story4 extends Story
{
	private var note:Note4;
	override public function write()
	{
		note = cast writtenNote;

		note.setAreaMap(note.entrance, eventAreaSprite.table);
	}
}
