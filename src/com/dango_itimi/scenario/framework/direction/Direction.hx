package com.dango_itimi.scenario.framework.direction;
import com.dango_itimi.scenario.framework.direction.Cut;

class Direction
{
	public var checked(default, null):Array<Cut>;
	public var fired(default, null):Array<Cut>;
	public var equipedIncorrectItem(default, null):Array<Cut>;

	public function new(checked:Array<Cut>, fired:Array<Cut>, equipedIncorrectItem:Array<Cut>)
	{
		this.checked = checked;
		this.fired = fired;
		this.equipedIncorrectItem = equipedIncorrectItem;
	}
}

