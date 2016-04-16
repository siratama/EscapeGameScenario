package com.dango_itimi.scenario.framework.save;

class Recorder
{
	private var record:Record;
	public function new()
	{
		record = loadRecord();
		if(record == null)
			record = {firedEventIdSet: []};
	}
	private function loadRecord():Record
	{
		return null;
	}
	public function save()
	{
		
	}

	public function addFiredEventId(firedEventId:String)
	{
		record.firedEventIdSet.push(firedEventId);
	}
	public function isEventNoneError():Bool
	{
		for(eventId in record.firedEventIdSet)
		{
			if(Type.resolveClass(eventId) == null)
				return true;
		}
		return false;
	}
}

