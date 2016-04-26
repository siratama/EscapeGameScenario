package com.dango_itimi.scenario.framework.direction.action;
interface ActionInterface
{
	public function initialize():Void;
	public function run():Void;
	public function isFinished():Bool;

	//for skip or save record
	public function playDirect():Bool;
}
