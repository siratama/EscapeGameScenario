package com.dango_itimi.scenario.framework.direction;
import com.dango_itimi.scenario.core.Event;

class DirectionMap
{
	private var map:Map<Event, Direction>;
	public function new()
	{
		map = new Map();
	}
	public inline function set(event:Event, checked:Array<Cut>, fired:Array<Cut>, equipedIncorrectItem:Array<Cut>)
	{
		map[event] = new Direction(checked, fired, equipedIncorrectItem);
	}
	public inline function get(event:Event):Direction
	{
		return map[event];
	}
}
