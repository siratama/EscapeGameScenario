package com.dango_itimi.escape_game;

import com.dango_itimi.escape_game.event.Book;
import com.dango_itimi.escape_game.event.Event;
import com.dango_itimi.geom.Point;

class BookReader
{
	private var book:Book;
	private var itemHolder:ItemHolder;

	public function new(book:Book, itemHolder:ItemHolder)
	{
		this.book = book;
		this.itemHolder = itemHolder;
	}

	//@return fired event
	public function progress(checkPosition:Point):Event
	{
		var readingStory = book.readingStory;

		var hitArea = readingStory.getHitArea(checkPosition);
		if(hitArea == null) return null;

		var event = readingStory.getEnabledEvent(hitArea);
		if(event == null) return null;

		if(!event.isFired(itemHolder.set)) return null;

		event.finish();

		if(!event.isBranched())
		{
			readingStory.setNextPriorityInArea(hitArea);
		}
		else
		{
			book.branchReadingStory(event.nextStory);
		}
		return event;
	}
}
