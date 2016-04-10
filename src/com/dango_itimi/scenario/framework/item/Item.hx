package com.dango_itimi.scenario.framework.item;

import com.dango_itimi.scenario.core.Event;
class Item extends Event
{
	public var name(default, null):String;

	public function initialize(name:String)
	{
		this.name = name;
	}
	public function select() {
		completed = true;
	}
	public function unselect() {
		completed = false;
	}
}
