package com.dango_itimi.scenario.core;

import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.geom.Point;
import com.dango_itimi.geom.Rectangle;

using com.dango_itimi.utils.MetaUtil;
using com.dango_itimi.geom.Rectangle;

class Scene
{
	public static inline var META_EVENT = "event";
	private var autoCreationEventInstanceClass:Class<Event>;
	//
	// event instance creation automatically
	// meta: @event
	//
	//@event public var table(default, null):Event;

	public var set(default, null):Array<Event>;
	private var areaMap:Map<Rectangle, Array<Event>>;

	public function new()
	{
		set = [];
		areaMap = new Map();

		createEventAutomatically();
	}

	//
	private function createEventAutomatically()
	{
		if(autoCreationEventInstanceClass == null) autoCreationEventInstanceClass = Event;

		var metaFieldSet = this.getMetaFieldsWithInstance(META_EVENT);
		for(metaField in metaFieldSet)
		{
			var eventId = Type.getClassName(Type.getClass(this)) + "." + metaField.name;
			var event = Type.createInstance(autoCreationEventInstanceClass, [eventId]);
			set.push(event);
			Reflect.setProperty(this, metaField.name, event);
		}
	}

	//
	public function setAreaMap(event:Event, hitArea:Rectangle)
	{
		if(!isPropertyInThisScene(event)) throw event + " is not property in this scene.";
		if(isIncludedInAreaMap(event)) throw event + "is included in areaMap already";

		if(areaMap[hitArea] == null) areaMap[hitArea] = [];
		areaMap[hitArea].push(event);
	}

	/*
	 * error check
	 */
	private function isPropertyInThisScene(checked:Event):Bool
	{
		for(event in set) if(checked == event) return true;
		return false;
	}
	private function isIncludedInAreaMap(checked:Event):Bool
	{
		for(hitArea in areaMap.keys())
		{
			for(event in areaMap[hitArea])
			{
				if(checked == event) return true;
			}
		}
		return false;
	}
	public function getUnSetEventsInAreaMap():Array<Event>
	{
		var unsetEvents:Array<Event> = [];
		for(event in set){
			if(!isIncludedInAreaMap(event)) unsetEvents.push(event);
		}
		return unsetEvents;
	}

	//
	public function getHitAreaSet(checkPosition:Point):Array<Rectangle>
	{
		var hitAreaSet = [];
		for (key in areaMap.keys())
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
		var eventSet:Array<Event> = areaMap[hitArea];

		for (event in eventSet)
			if(event.enabled) enabledEventSet.push(event);

		return enabledEventSet;
	}
}
