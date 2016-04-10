package haxegame.game.scenario_error.overlapping_area;

import com.dango_itimi.escape_game.book.Note;
import com.dango_itimi.escape_game.book.Event;
import com.dango_itimi.escape_game.book.Book;

class Novel extends Book
{
	@note public var note1(default, null):Note1;
}
class Note1 extends Note
{
	@event public var table(default, null):Event;
	@event public var bed(default, null):Event;
	@event public var floor(default, null):Event;
	@event public var window(default, null):Event;
}
