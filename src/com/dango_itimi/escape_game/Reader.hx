package com.dango_itimi.escape_game;

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

class Reader
{
	private var book:Book;
	private var itemHolder:ItemHolder;

	public function new(book:Book, itemHolder:ItemHolder)
	{
		this.book = book;
		this.itemHolder = itemHolder;
	}
	public function progress(checkPosition:Point):Progress
	{
		var readingStory = book.readingNote;

		var hitArea = readingStory.getHitArea(checkPosition);
		if(hitArea == null)
			return Progress.NO_HITAREA;

		var event = readingStory.getEnabledEvent(hitArea);
		if(event == null)
			return Progress.NO_ENABLED_EVENT;

		var eventCondition = event.getCondision(itemHolder.set);
		switch(eventCondition){

			case EventCondition.MISFIRED(misfired, itemLack, unfinishedAllRequiredEvents):
				return Progress.MISFIRED(event, misfired, itemLack, unfinishedAllRequiredEvents);

			case EventCondition.FIRED:
			
				event.finish();
				if(!event.isBranched())
					readingStory.setNextPriorityInArea(hitArea);
				else
					book.branchReadingNote(event.nextStory);

				return Progress.NEXT(event);
		}
	}
}
