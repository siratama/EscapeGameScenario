package com.dango_itimi.scenario.framework;

import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.framework.direction.Cut;
import com.dango_itimi.scenario.framework.direction.Direction;
import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.scenario.core.Scene;
import com.dango_itimi.scenario.core.Scenario;
import com.dango_itimi.geom.Point;

class Director
{
	private var projector:Projector;
	private var itemHolder:Inventory;
	private var directionMap:DirectionMap;

	public function new(projector:Projector, itemHolder:Inventory, directionMap:DirectionMap)
	{
		this.projector = projector;
		this.itemHolder = itemHolder;
		this.directionMap = directionMap;
	}

	//
	public function progress(scene:Scene, checkPosition:Point)
	{
		switch(Scenario.read(scene, checkPosition))
		{
			case Progress.NO_HITAREA | Progress.NO_ENABLED_EVENT: return;

			case Progress.NONATTAINMENT(event, nonAttainment):
				orderNonattainment(event);

			case Progress.ADVANCE(complatableEvent):
				orderAdvance(complatableEvent);
		}
	}
	private function orderNonattainment(event:Event)
	{
		var direction:Direction = directionMap.get(event);

		for(actions in direction.equipedIncorrectItem)
		{
			var incorrectItem = cast(actions, EquipedIncorrectItemCut).incorrectItem;
			if(event.isRequiredCompletionEvent(incorrectItem) && itemHolder.isSelected(incorrectItem))
			{
				projector.initialize(direction.equipedIncorrectItem);
				return;
			}
		}

		if(direction.checked != null){
			projector.initialize(direction.checked);
		}
	}
	private function orderAdvance(event:Event)
	{
		event.complete();

		var direction:Direction = directionMap.get(event);
		projector.initialize(direction.fired);
	}
}



