package com.dango_itimi.scenario.framework.save;

import haxe.Unserializer;
import haxe.Serializer;
import com.dango_itimi.scenario.core.Event;

class Recorder
{
	private var record:Record;
	public function new(loadedSerializedRecord:String)
	{
		record = (loadedSerializedRecord == null) ? {firedEventIdSet: []}: Unserializer.run(loadedSerializedRecord);
	}
	public function add(firedEventId:String)
	{
		record.firedEventIdSet.push(firedEventId);
	}
	public function checkSavedEventNullError(eventMap:Map<String, Event>)
	{
		for(eventId in record.firedEventIdSet)
		{
			if(eventMap[eventId] == null)
				throw eventId + " is not found";
		}
	}
	public function getRecordedEventSet(eventMap:Map<String, Event>):Array<Event>
	{
		var eventSet = [];
		for(eventId in record.firedEventIdSet)
		{
			var event = eventMap[eventId];
			eventSet.push(event);
		}
		return eventSet;
	}
	public function getSerializedRecord():String
	{
		return Serializer.run(record);
	}
}

