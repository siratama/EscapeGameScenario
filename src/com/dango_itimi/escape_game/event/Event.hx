package com.dango_itimi.escape_game.event;

import com.dango_itimi.escape_game.event.Story;
import com.dango_itimi.escape_game.item.Item;

class Event
{
	public var requiredItems(default, set):Array<Item>;
	public function set_requiredItems(requiredItems:Array<Item>):Array<Item>
		return this.requiredItems = requiredItems;
	
	public var removedItems(default, set):Array<Item>;
	public function set_removedItems(removedItems:Array<Item>):Array<Item>
		return this.removedItems = removedItems;
	
	public var gottenItems(default, set):Array<Item>;
	public function set_gottenItems(gottenItems:Array<Item>):Array<Item>
		return this.gottenItems = gottenItems;
	

	public var requiredFinishEvents(null, set):Array<Event>;
	public function set_requiredFinishEvents(requiredFinishEvents:Array<Event>):Array<Event>
		return this.requiredFinishEvents = requiredFinishEvents;
	

	public var checkedTexts(default, null):Array<String>;
	public var firedTexts(default, null):Array<String>;

	public var unfired(default, null):Bool;
	public var enabled(default, null):Bool;
	public var finished(default, null):Bool;

	public var lasted(default, set):Bool;
	public function set_lasted(lasted:Bool):Bool
		return this.lasted = lasted;

	public var nextStory(default, set):Story;
	public function set_nextStory(nextStory:Story):Story
		return this.nextStory = nextStory;

	public function isBranched():Bool
		return nextStory != null;

	public var option(default, set):Dynamic;
	public function set_option(option:Dynamic):Dynamic
		return this.option = option;

	public function new(){
		enabled = false;
		unfired = false;
		finished = false;
	}

	public function initializeUnqualified(firedTexts:Array<String>)
	{
		this.firedTexts = firedTexts;
	}
	public function initialize(checkedTexts:Array<String>, firedTexts:Array<String>)
	{
		this.checkedTexts = checkedTexts;
		this.firedTexts = firedTexts;
	}
	public function initializeUnfired(checkedTexts:Array<String>)
	{
		this.checkedTexts = checkedTexts;
		unfired = true;
	}

	public function isFired(ownItems:Array<Item>):Bool
	{
		if(unfired) return false;
		if(finished) return false;

		var result = isReqiredItemsOwner(ownItems);
		if(!result) return false;

		return isFinishedAllReairedEvents();
	}
	private function isReqiredItemsOwner(ownItems:Array<Item>):Bool
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
	private function isFinishedAllReairedEvents():Bool
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

