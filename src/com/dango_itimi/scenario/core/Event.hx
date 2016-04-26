package com.dango_itimi.scenario.core;

class Event
{
	public var id(default, null):String;
	public var enabled(default, null):Bool;
	private var completed:Bool;
	
	public var requiredCompletionEvents:Array<Event>;
	public var enabledEventsAfterCompletion:Array<Event>;
	public var disenabledEventsAfterCompletion:Array<Event>;

	public function new(id:String)
	{
		this.id = id;

		enabled = false;
		completed = false;

		requiredCompletionEvents = [];
		enabledEventsAfterCompletion = [];
		disenabledEventsAfterCompletion = [];
	}
	public function enable() {
		enabled = true;
		completed = false;
	}
	public function disenable() {
		enabled = false;
	}
	public function isCompletable():Bool
	{
		for (event in requiredCompletionEvents)
		{
			if(!event.completed) return false;
		}
		return true;
	}
	public function complete()
	{
		enabled = false;
		completed = true;
		for(event in enabledEventsAfterCompletion) event.enable();
		for(event in disenabledEventsAfterCompletion) event.disenable();
	}
	public function isRequiredCompletionEvent(checked:Event):Bool
	{
		for (event in requiredCompletionEvents)
		{
			if(checked == event) return true;
		}
		return false;
	}
}

