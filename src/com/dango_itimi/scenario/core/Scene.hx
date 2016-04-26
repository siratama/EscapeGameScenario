package com.dango_itimi.scenario.core;

import com.dango_itimi.scenario.core.Event;
using com.dango_itimi.utils.MetaUtil;

class Scene
{
	public static inline var META_EVENT = "event";
	private var autoCreationEventInstanceClass:Class<Event>;
	//
	// event instance creation automatically
	// meta: @event
	//
	//@event public var table(default, null):Event;

	public var eventSet(default, null):Array<Event>;

	public function new()
	{
		eventSet = [];
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
			eventSet.push(event);
			Reflect.setProperty(this, metaField.name, event);
		}
	}
}
