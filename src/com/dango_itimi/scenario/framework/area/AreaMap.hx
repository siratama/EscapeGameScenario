package com.dango_itimi.scenario.framework.area;

import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.geom.Rectangle;
import com.dango_itimi.geom.Point;
using com.dango_itimi.geom.Rectangle;

class AreaMap
{
	private var map:Map<Rectangle, Array<Event>>;

	public function new()
	{
		map = new Map();
	}

	public function set(hitArea:Rectangle, event:Event)
	{
		if(isIncludedInAreaMap(event)) throw event.id + "is included in area map already";

		if(map[hitArea] == null) map[hitArea] = [];
		map[hitArea].push(event);
	}
	public function isIncludedInAreaMap(checked:Event):Bool
	{
		for(hitArea in map.keys())
		{
			for(event in map[hitArea])
			{
				if(checked == event) return true;
			}
		}
		return false;
	}

	public function getHitAreaSet(checkPosition:Point):Array<Rectangle>
	{
		var hitAreaSet = [];
		for (key in map.keys())
		{
			var hitArea:Rectangle = key;
			if(hitArea.hitTestPoint(checkPosition))
				hitAreaSet.push(hitArea);
		}
		return hitAreaSet;
	}
	public function getEnabledEventSet(hitArea:Rectangle):Array<Event>
	{
		var enabledEventSet = [];
		var eventSet:Array<Event> = map[hitArea];

		for (event in eventSet)
			if(event.enabled) enabledEventSet.push(event);

		return enabledEventSet;
	}
}
