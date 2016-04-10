package haxegame.game.scenario.story;

import com.dango_itimi.escape_game.book.Note;
import com.dango_itimi.escape_game.book.Event;
import haxegame.game.item.GameItems;

class Story
{
	public var eventOptionMap(null, default):Map<Event, EventOption>;
	public var eventAreaSprite(null, default):EventAreaSprite;
	public var items(null, default):GameItems;
	public var writtenNote(null, default):Note;

	public function write(){}
}
