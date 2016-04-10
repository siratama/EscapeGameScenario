package com.dango_itimi.escape_game.book;

import com.dango_itimi.geom.Point;
import com.dango_itimi.geom.Rectangle;
import com.dango_itimi.escape_game.book.Event;

using com.dango_itimi.utils.MetaUtil;
using com.dango_itimi.geom.Rectangle.RectangleUtil;

class Note
{
	public static inline var META_EVENT = "event";
	private var autoCreationEventInstanceClass:Class<Event>;
	//
	// auto creation event instance
	// meta: @event
	//
	//@event public var table(default, null):Event;

	private var set:Array<Event>;
	private var areaMap:Map<Rectangle, Array<Event>>;

	public function new()
	{
		set = [];
		areaMap = new Map();

		createEventAuto();
	}

	//
	private function createEventAuto()
	{
		if(autoCreationEventInstanceClass == null) autoCreationEventInstanceClass = Event;

		var metaFieldSet = this.getMetaFieldsWithInstance(META_EVENT);
		for(metaField in metaFieldSet){
			var event = Type.createInstance(autoCreationEventInstanceClass, []);
			set.push(event);
			Reflect.setProperty(this, metaField.name, event);
		}
	}

	//
	public function setAreaMap(event:Event, hitArea:Rectangle)
	{
		if(areaMap[hitArea] == null) areaMap[hitArea] = [];
		areaMap[hitArea].push(event);
	}

	//
	public function checkOverlappingArea()
	{
		for (key in areaMap.keys())
		{
			var hitArea1:Rectangle = key;
			for (key2 in areaMap.keys())
			{
				var hitArea2:Rectangle = key2;
				if(hitArea1 == hitArea2) continue;
				if(hitArea1.hitTestObject(hitArea2)){
					throw "overlapping area: " + hitArea1 + ":" + hitArea2;
				}
			}
		}
	}
	public function checkEventOrderError()
	{
		for (key in areaMap.keys())
		{
			var eventSet:Array<Event> = areaMap[key];
			for (i in 0...eventSet.length)
			{
				var event = eventSet[i];
				if(event.endless && i < eventSet.length - 1){
					throw "need to set misfired event at the end:" + event;
				}
			}
		}
	}

	//
	public function getHitArea(checkPosition:Point):Rectangle
	{
		for (key in areaMap.keys())
		{
			var hitArea:Rectangle = key;
			if(hitArea.hitTestPoint(checkPosition))
				return hitArea;
		}
		return null;
	}
	public function getEnabledEvent(hitArea:Rectangle):Event
	{
		var eventSet:Array<Event> = areaMap[hitArea];

		for (event in eventSet)
			if(event.enabled) return event;

		return null;
	}

	//
	public function enable(enabled:Bool)
	{
		for(event in set) event.enable(enabled);
	}
	public function initializePriorityInArea()
	{
		for (key in areaMap.keys())
		{
			var eventSet:Array<Event> = areaMap[key];
			for (i in 0...eventSet.length)
			{
				var event = eventSet[i];
				var enabled = (i == 0);
				event.enable(enabled);
			}
		}
	}
	public function setNextPriorityInArea(hitArea:Rectangle)
	{
		var eventSet:Array<Event> = areaMap[hitArea];
		for (i in 0...eventSet.length)
		{
			var event = eventSet[i];
			if(event.finished) continue;

			event.enable(true);
			break;
		}
	}
	public function setPriorityInAreaWithExchangedReading()
	{
		for (key in areaMap.keys())
		{
			var eventSet:Array<Event> = areaMap[key];
			for (i in 0...eventSet.length)
			{
				var event = eventSet[i];
				if(event.finished) continue;

				event.enable(true);
				break;
			}
		}
	}
}
