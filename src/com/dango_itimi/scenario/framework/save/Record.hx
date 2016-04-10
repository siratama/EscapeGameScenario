package com.dango_itimi.scenario.framework.save;

class Record
{
	private var eventIdTrack:Array<String>;
	public function new()
	{
		eventIdTrack = [];
	}
	public function add(eventId:String)
	{
		eventIdTrack.push(eventId);
	}
	public function isEventNoneError():Bool
	{
		for(eventId in eventIdTrack)
		{
			if(Type.resolveClass(eventId) == null)
				return true;
		}
		return false;
	}
}
