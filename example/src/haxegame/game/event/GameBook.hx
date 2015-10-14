package haxegame.game.event;

import haxegame.game.item.GameItems;
import com.dango_itimi.escape_game.item.Items;
import haxegame.game.event.GameStory;
import com.dango_itimi.escape_game.event.Book;
import com.dango_itimi.escape_game.event.Story;

class GameBook extends Book
{
	@story public var story1(default, null):Story1;
	@story public var story2(default, null):Story2;
	@story public var story3(default, null):Story3;

	private var eventAreaSprite:EventAreaSprite;
	private var items:GameItems;

	public function new()
	{
		eventAreaSprite = new EventAreaSprite();
		items = GameItems.instance;

		super();

		setReadingStory(story1);
	}
	override private function setStoryField(story:Story)
	{
		cast(story, GameStory).eventAreaSprite = eventAreaSprite;
		cast(story, GameStory).items = items;
	}
	override private function setBranch()
	{
		story1.box.nextStory = story2;
	}
}
