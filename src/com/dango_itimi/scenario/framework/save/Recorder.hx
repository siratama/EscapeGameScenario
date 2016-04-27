package com.dango_itimi.scenario.framework.save;

import com.dango_itimi.scenario.core.Event;

class Recorder
{
	public var record(default, null):Record;
	public function new(loadedRecord:Record)
	{
		record = (loadedRecord == null) ? {firedEventIdSet: []}: loadedRecord;
	}
	public function add(firedEventId:String)
	{
		record.firedEventIdSet.push(firedEventId);
	}
	public function checkSavedEventNullError()
	{
		for(eventId in record.firedEventIdSet)
		{
			if(Type.resolveClass(eventId) == null)
				throw eventId + " is not found";
		}
	}
	public function getRecordedEventSet():Array<Event>
	{
		var eventSet = [];
		for(eventId in record.firedEventIdSet)
		{
			var eventClass:Class<Event> = Type.resolveClass(eventId);
			var event:Event = Type.createInstance(eventClass, [eventId]);
			eventSet.push(event);
		}
		return eventSet;
	}
}

