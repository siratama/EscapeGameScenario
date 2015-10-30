package com.dango_itimi.escape_game.book;

import com.dango_itimi.escape_game.book.Note;
import com.dango_itimi.escape_game.item.Item;

enum EventCondition
{
	FIRED;
	MISFIRED(misfiredSetting:Bool, itemLack:Bool, unfinishedAllRequiredEvents:Bool);
}

class Event
{
	public var requiredItems:Array<Item>;
	public var removedItems:Array<Item>;
	public var gottenItems:Array<Item>;
	public var requiredFinishEvents:Array<Event>;

	public var misfired:Bool;
	public var enabled(default, null):Bool;
	public var finished(default, null):Bool;

	public var nextNote:Note;
	public function isBranched():Bool
		return nextNote != null;

	public var option:Dynamic;

	public function new(){
		enabled = false;
		misfired = false;
		finished = false;
	}
	public function getCondision(ownItems:Array<Item>):EventCondition
	{
		var itemLack = !isRequiredItemsOwner(ownItems);
		var unfinishedAllRequiredEvents = !isFinishedAllRequiredEvents();

		if(misfired || itemLack || unfinishedAllRequiredEvents)
			return EventCondition.MISFIRED(misfired, itemLack, unfinishedAllRequiredEvents);

		return EventCondition.FIRED;
	}
	private function isRequiredItemsOwner(ownItems:Array<Item>):Bool
	{
		if(requiredItems == null) return true;

		for (requiredItem in requiredItems)
		{
			var had = false;
			for (ownItem in ownItems)
			{
				if(requiredItem == ownItem){
					had = true;
					break;
				}
			}
			if(!had) return false;
		}
		return true;
	}
	private function isFinishedAllRequiredEvents():Bool
	{
		if(requiredFinishEvents == null) return true;

		for (event in requiredFinishEvents)
		{
			if(event.finished) continue;
			return false;
		}
		return true;
	}

	public function enable(enabled:Bool)
	{
		this.enabled = enabled;
	}
	public function finish()
	{
		finished = true;
		enabled = false;
	}
}

