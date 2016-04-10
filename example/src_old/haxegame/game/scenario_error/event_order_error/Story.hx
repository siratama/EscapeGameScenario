package haxegame.game.scenario_error.event_order_error;

import com.dango_itimi.geom.Rectangle.RectangleUtil;
import haxegame.game.scenario_error.event_order_error.Novel.Note1;
import com.dango_itimi.escape_game.book.Note;

class Story
{
	public var writtenNote(null, default):Note;
	public function new(){}
	public function write(){}
}
class Story1 extends Story
{
	private var note:Note1;

	override public function write()
	{
		note = cast writtenNote;

		var rectangle1 = RectangleUtil.create(0, 0, 10, 10);
		var rectangle2 = RectangleUtil.create(11, 0, 10, 10);

		note.setAreaMap(note.table, rectangle1);

		note.setAreaMap(note.bed, rectangle2);
		note.bed.misfired = true;

		note.setAreaMap(note.floor, rectangle2);
	}
}
