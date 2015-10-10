package haxegame.game.event;

import haxegame.game.event.GameStory;
import com.dango_itimi.escape_game.event.Book;
import com.dango_itimi.escape_game.event.Story;

class GameBook extends Book
{
	@story public var story1(default, null):Story1;
	@story public var story2(default, null):Story2;
	@story public var story3(default, null):Story3;

	private var eventAreaSprite:EventAreaSprite;

	public function new()
	{
		eventAreaSprite = new EventAreaSprite();

		super();

		setReadingStory(story1);
	}
	override private function setStoryField(story:Story)
	{
		cast(story, GameStory).eventAreaSprite = eventAreaSprite;
	}
	override private function setBranch()
	{
		story1.floor.nextStory = story2;
	}
}
