package haxegame.game.scenario;

import com.dango_itimi.escape_game.book.Event;
import com.dango_itimi.escape_game.book.Book;
import com.dango_itimi.escape_game.book.Note;

class Novel extends Book
{
	@note public var note1(default, null):Note1;
	@note public var note2(default, null):Note2;
	@note public var note3(default, null):Note3;
}
class Note1 extends Note
{
	@event public var table(default, null):Event;
	@event public var bed(default, null):Event;
	@event public var floor(default, null):Event;
	@event public var box(default, null):Event;
	@event public var window(default, null):Event;
}
class Note2 extends Note
{
	@event public var table(default, null):Event;
	@event public var mirror(default, null):Event;
	@event public var box(default, null):Event;
}
class Note3 extends Note
{
	@event public var table(default, null):Event;
	@event public var box(default, null):Event;
}
