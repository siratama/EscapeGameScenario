package com.dango_itimi.escape_game;

import com.dango_itimi.geom.Rectangle;
import com.dango_itimi.escape_game.book.Note;
import com.dango_itimi.escape_game.book.Book;
import com.dango_itimi.escape_game.book.Event;
import com.dango_itimi.geom.Point;

enum Progress
{
	NO_HITAREA;
	NO_ENABLED_EVENT;
	MISFIRED(misfiredEvent:Event, misfiredSetting:Bool, itemLack:Bool, unfinishedAllRequiredEvents:Bool);
	NEXT(firedEvent:Event);
}
class ProgressProperty
{
	public var readingNote(default, null):Note;
	public var progress(default, null):Progress;
	public function new(readingNote:Note, progress:Progress)
	{
		this.readingNote = readingNote;
		this.progress = progress;
	}
}

class Reader
{
	private var book:Book;
	private var itemHolder:ItemHolder;

	public function new(book:Book, itemHolder:ItemHolder)
	{
		this.book = book;
		this.itemHolder = itemHolder;
	}

	public function isProgressEventExisted(checkPosition:Point):Bool
	{
		for (readingNote in book.readingNotes)
		{
			var hitArea = readingNote.getHitArea(checkPosition);
			if(hitArea == null)
				return false;

			var event = readingNote.getEnabledEvent(hitArea);
			if(event == null)
				return false;
		}
		return true;
	}
	public function progress(checkPosition:Point):Array<ProgressProperty>
	{
		var progressPropertySet = [];
		for (readingNote in book.readingNotes)
		{
			var progress = read(readingNote, checkPosition);
			var progressProperty = new ProgressProperty(readingNote, progress);
			progressPropertySet.push(progressProperty);
		}
		return progressPropertySet;
	}
	private function read(readingNote:Note, checkPosition:Point):Progress
	{
		var hitArea = readingNote.getHitArea(checkPosition);
		if(hitArea == null)
			return Progress.NO_HITAREA;

		var event = readingNote.getEnabledEvent(hitArea);
		if(event == null)
			return Progress.NO_ENABLED_EVENT;

		var eventCondition = event.getCondision(itemHolder.set);
		switch(eventCondition){

			case EventCondition.MISFIRED(misfired, itemLack, unfinishedAllRequiredEvents):
				return Progress.MISFIRED(event, misfired, itemLack, unfinishedAllRequiredEvents);

			case EventCondition.FIRED:

				event.finish();
				if(!event.isBranched())
					readingNote.setNextPriorityInArea(hitArea);
				else
					book.branchReadingNote(readingNote, event.nextNote);

				return Progress.NEXT(event);
		}
	}
}
