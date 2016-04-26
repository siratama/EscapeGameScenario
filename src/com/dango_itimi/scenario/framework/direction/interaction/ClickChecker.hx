package com.dango_itimi.scenario.framework.direction.interaction;
class ClickChecker extends Interaction
{
	public var clicked(null, set):Bool;
	public function set_clicked(clicked:Bool):Bool
		return this.clicked = clicked;

	override public function initialize()
	{
		clicked = false;
		super.initialize();
	}
	override private function watch()
	{
		if(clicked)
			mainFunction = execute;
	}
}
