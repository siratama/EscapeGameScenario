package com.dango_itimi.escape_game;

import com.dango_itimi.escape_game.event.Book;
import com.dango_itimi.escape_game.event.Event;
import com.dango_itimi.escape_game.item.Item;
import com.dango_itimi.geom.Point;

class BookReader
{
	private var book:Book;

	public function new(book:Book)
	{
		this.book = book;
	}

	//@return fired event
	public function progress(checkPosition:Point, ownItems:Array<Item>):Event
	{
		var readingStory = book.readingStory;

		var hitArea = readingStory.getHitArea(checkPosition);
		if(hitArea == null) return null;

		var event = readingStory.getEnabledEvent(hitArea);
		if(event == null) return null;

		if(!event.isFired(ownItems)) return null;

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
