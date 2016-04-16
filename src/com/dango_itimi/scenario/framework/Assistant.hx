package com.dango_itimi.scenario.framework;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.core.Sequence;
class Assistant
{
	public static function checkError(sequence:Sequence, directionMap:DirectionMap)
	{
		for(scene in sequence.scenes)
		{
			for(event in scene.set)
			{
				if(Std.is(event, Item)) continue;

				if(directionMap.get(event) == null){
					throw "does not set direction:" + event.id;
				}
			}
		}
	}
	public static function test(sequence:Sequence)
	{
		for(scene in sequence.scenes)
		{
		}
	}
}