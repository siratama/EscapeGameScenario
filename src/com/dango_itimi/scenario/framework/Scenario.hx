package com.dango_itimi.scenario.framework;

import com.dango_itimi.scenario.core.Scene;
import com.dango_itimi.scenario.framework.area.AreaManager;
import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.geom.Point;

enum Progress
{
	NO_HITAREA;
	NO_ENABLED_EVENT;
	UNCOMPLETABLE(event:Event);
	ADVANCE(complatableEvent:Event);
}

class Scenario
{
	public static function hasProgressEvent(areaManager:AreaManager, scene:Scene, checkPosition:Point):Bool
	{
		return switch(read(areaManager, scene, checkPosition))
		{
			case Progress.ADVANCE: true;
			case _: false;
		}
	}
	public static function read(areaManager:AreaManager, scene:Scene, checkPosition:Point):Progress
	{
		var areaMap = areaManager.getAreaMap(scene);
		var hitAreaSet = areaMap.getHitAreaSet(checkPosition);
		if(hitAreaSet.length == 0)
			return Progress.NO_HITAREA;

		var enabledEventSet:Array<Event> = [];
		for(hitArea in hitAreaSet)
		{
			var eventSet = areaMap.getEnabledEventSet(hitArea);
			enabledEventSet = enabledEventSet.concat(eventSet);
			if(enabledEventSet.length > 1)
				throw "enabled event setting error";
		}

		if(enabledEventSet.length == 0)
			return Progress.NO_ENABLED_EVENT;

		var event = enabledEventSet[0];
		return (!event.isCompletable()) ? Progress.UNCOMPLETABLE(event): Progress.ADVANCE(event);
	}
}
