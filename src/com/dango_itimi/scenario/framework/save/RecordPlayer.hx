package com.dango_itimi.scenario.framework.save;
import com.dango_itimi.scenario.framework.direction.Cut.ItemChangeCut;
import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
class RecordPlayer
{
	public static function play(eventSet:Array<Event>, inventory:Inventory, directionMap:DirectionMap)
	{
		for(event in eventSet)
		{
			var firedFilm = directionMap.get(event).firedFilm;
			for(cut in firedFilm.cutSet)
			{
				if(Std.is(cut, ItemChangeCut))
					inventory.change(cast(cut, ItemChangeCut).itemChange);

				cut.action.initialize();
				cut.action.playDirect();
			}
		}
	}
}
