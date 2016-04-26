package com.dango_itimi.scenario.framework.direction;

import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.core.Event;

class DirectionMap
{
	private var map:Map<Event, Direction>;
	public function new()
	{
		map = new Map();
	}
	public function set(event:Event, ?firedFilm:FiredFilm, ?checkedFilm:CheckedFilm, ?equipedIncorrectItemFilm:EquipedIncorrectItemFilm)
	{
		if(map[event] != null)
			throw event.id + " is included in direction map already";

		if(equipedIncorrectItemFilm != null && firedFilm == null)
			throw "Set firedFilm: " + event.id;

		if(equipedIncorrectItemFilm != null && isUnsetRequiredItems(event, equipedIncorrectItemFilm))
			throw "Set Item to requiredCompletionEvents: " + event.id;

		map[event] = new Direction(firedFilm, checkedFilm, equipedIncorrectItemFilm);
	}
	private function isUnsetRequiredItems(event:Event, equipedIncorrectItemFilm:Film):Bool
	{
		if(event.requiredCompletionEvents == null)
			return true;

		for(requiredCompletionEvent in event.requiredCompletionEvents)
		{
			if(Std.is(requiredCompletionEvent, Item)) return false;
		}
		return true;
	}

	public inline function get(event:Event):Direction
	{
		return map[event];
	}
}
