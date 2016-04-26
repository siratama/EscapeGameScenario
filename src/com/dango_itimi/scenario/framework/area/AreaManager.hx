package com.dango_itimi.scenario.framework.area;
import com.dango_itimi.scenario.core.Sequence;
import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.scenario.core.Scene;
import com.dango_itimi.geom.Rectangle;
import com.dango_itimi.scenario.framework.area.AreaMap;

class AreaManager
{
	private var map:Map<Scene, AreaMap>;
	private var eventMap:Map<Event, Scene>;

	public function new()
	{
		map = new Map();
		eventMap = new Map();
	}
	public function register(sequence:Sequence)
	{
		for(scene in sequence.sceneSet)
		{
			map[scene] = new AreaMap();
			for(event in scene.eventSet)
			{
				eventMap[event] = scene;
			}
		}
	}
	public function set(hitArea:Rectangle, event:Event)
	{
		var scene = eventMap[event];
		var areaMap = getAreaMap(scene);
		areaMap.set(hitArea, event);
	}
	public function getAreaMap(scene:Scene):AreaMap
	{
		return map[scene];
	}
	public function isIncludedInAreaMap(checked:Event):Bool
	{
		var scene = eventMap[checked];
		var areaMap = getAreaMap(scene);
		return areaMap.isIncludedInAreaMap(checked);
	}
}
