package com.dango_itimi.scenario.core;

import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.geom.Point;

enum Progress
{
	NO_HITAREA;
	NO_ENABLED_EVENT;
	NONATTAINMENT(event:Event, nonAttainment:NonAttainment);
	ADVANCE(complatableEvent:Event);
}
enum NonAttainment
{
	ENDLESS;
	UNCOMPLETABLE;
}

class Scenario
{
	public static function hasProgressEvent(scene:Scene, checkPosition:Point):Bool
	{
		return switch(read(scene, checkPosition))
		{
			case Progress.ADVANCE: true;
			case _: false;
		}
	}
	public static function read(scene:Scene, checkPosition:Point):Progress
	{
		var hitAreaSet = scene.getHitAreaSet(checkPosition);
		if(hitAreaSet.length == 0)
			return Progress.NO_HITAREA;

		var enabledEventSet:Array<Event> = [];
		for(hitArea in hitAreaSet)
		{
			var eventSet = scene.getEnabledEventSet(hitArea);
			enabledEventSet = enabledEventSet.concat(eventSet);
			if(enabledEventSet.length > 1)
				throw "enabled event setting error";
		}

		if(enabledEventSet.length == 0)
			return Progress.NO_ENABLED_EVENT;

		var event = enabledEventSet[0];

		return
			(event.endless) ?
				Progress.NONATTAINMENT(event, NonAttainment.ENDLESS):
			(!event.isCompletable()) ?
				Progress.NONATTAINMENT(event, NonAttainment.UNCOMPLETABLE):

				Progress.ADVANCE(event);
	}
}
