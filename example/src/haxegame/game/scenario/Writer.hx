package haxegame.game.scenario;

import haxegame.game.scenario.story.*;
import haxegame.game.item.GameItems;
import com.dango_itimi.escape_game.book.Event;
import com.dango_itimi.escape_game.book.Note;

using com.dango_itimi.utils.MetaUtil;

class Writer
{
	public var novel(default, null):Novel;
	public var eventOptionMap(default, null):Map<Event, EventOption>;

	private var eventAreaSprite:EventAreaSprite;
	private var items:GameItems;

	private var storySet:Array<Story>;
	private var story1:Story1;
	private var story2:Story2;
	private var story3:Story3;

	public function new()
	{
		eventOptionMap = new Map();
		eventAreaSprite = new EventAreaSprite();
		items = GameItems.instance;

		novel = new Novel();

		//write event
		storySet = [];
		execute(Story1, novel.note1);
		execute(Story2, novel.note2);
		execute(Story3, novel.note3);

		//set branch
		novel.note1.box.nextStory = novel.note2;

		novel.setReadingNote(novel.note1);
		novel.checkSettingError();
	}
	private function execute(storyClass:Class<Story>, note:Note)
	{
		//var story:Story = Type.createInstance(storyClass, []);
		var story:Story = Type.createEmptyInstance(storyClass);

		story.eventOptionMap = eventOptionMap;
		story.eventAreaSprite = eventAreaSprite;
		story.items = items;
		story.writtenNote = note;

		story.write();
		storySet.push(story);
	}
}


