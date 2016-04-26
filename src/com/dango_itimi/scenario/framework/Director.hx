package com.dango_itimi.scenario.framework;

import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.area.AreaManager;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.framework.direction.Direction;
import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.scenario.core.Scene;
import com.dango_itimi.scenario.framework.Scenario;
import com.dango_itimi.geom.Point;

class Director
{
	private var inventory:Inventory;
	private var directionMap:DirectionMap;
	private var areaManager:AreaManager;

	public function new(inventory:Inventory, directionMap:DirectionMap, areaManager:AreaManager)
	{
		this.inventory = inventory;
		this.directionMap = directionMap;
		this.areaManager = areaManager;
	}

	//
	public function progress(scene:Scene, checkPosition:Point):Film
	{
		switch(Scenario.read(areaManager, scene, checkPosition))
		{
			case Progress.NO_HITAREA | Progress.NO_ENABLED_EVENT:
				return null;

			case Progress.UNCOMPLETABLE(event):
				return orderNonattainment(event);

			case Progress.ADVANCE(complatableEvent):
				return orderAdvance(complatableEvent);
		}
	}
	private function orderNonattainment(event:Event):Film
	{
		var direction:Direction = directionMap.get(event);

		if(
			direction.equipedIncorrectItemFilm != null &&
			inventory.isSelected(direction.equipedIncorrectItemFilm.item)
		){
			return direction.equipedIncorrectItemFilm;
		}
		else if(direction.checkedFilm != null){
			return direction.checkedFilm;
		}
		return null;
	}
	private function orderAdvance(event:Event):Film
	{
		event.complete();

		var direction:Direction = directionMap.get(event);
		return direction.firedFilm;
	}
}



