package haxegame.game.scenario;

import haxegame.game.scenario.story.*;
import haxegame.game.item.GameItems;
import com.dango_itimi.escape_game.book.Event;
import com.dango_itimi.escape_game.book.Note;

using com.dango_itimi.utils.MetaUtil;

class Writer
{
	public var novel(default, null):Chapter;
	public var eventOptionMap(default, null):Map<Event, EventOption>;

	private var eventAreaSprite:EventAreaSprite;
	private var items:GameItems;

	private var storySet:Array<Episode>;
	public var story1(default, null):Story1;
	public var story2(default, null):Story2;
	public var story3(default, null):Story3;
	public var story4(default, null):Story4;

	public function new()
	{
		eventOptionMap = new Map();
		eventAreaSprite = new EventAreaSprite();
		items = GameItems.instance;

		novel = new Chapter();

		//write event
		storySet = [];
		execute(Story1, novel.note1);
		execute(Story2, novel.note2);
		execute(Story3, novel.note3);
		execute(Story4, novel.note4);

		//set branch
		novel.note1.box.nextNote = novel.note2;

		initializeToReadNote();

		novel.checkSettingError();
	}
	private function execute(storyClass:Class<Episode>, note:Note)
	{
		var story:Episode = Type.createEmptyInstance(storyClass);

		story.directionMap = eventOptionMap;
		story.eventAreaSprite = eventAreaSprite;
		story.items = items;
		story.writtenNote = note;

		story.write();
		storySet.push(story);
	}
	private function initializeToReadNote(){}
}
class SingleProgressWriter extends Writer
{
	override private function initializeToReadNote()
	{
		chapter.addReadingNote(chapter.note1);
	}
}
class MultiProgressWriter extends Writer
{
	override private function initializeToReadNote()
	{
		chapter.addReadingNote(chapter.note1);
		chapter.addReadingNote(chapter.note4);
	}
}

