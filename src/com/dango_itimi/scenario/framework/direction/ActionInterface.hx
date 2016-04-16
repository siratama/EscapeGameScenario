package com.dango_itimi.scenario.framework.direction;
interface ActionInterface
{
	public function initialize():Void;
	public function run():Void;
	public function isFinished():Bool;

	//for skip or save record
	public function playDirect():Void;
}
