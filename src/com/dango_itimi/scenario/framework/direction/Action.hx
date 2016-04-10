package com.dango_itimi.scenario.framework.direction;

class Action implements IAction
{
	private var mainFunction:Void->Void;

	public function new()
	{
	}
	public function run()
	{
		mainFunction();
	}
	public function initialize()
	{
		mainFunction = play;
	}
	private function play()
	{
		mainFunction = finish;
	}
	public function playDirect()
	{
		mainFunction = finish;
	}

	private function finish(){}
	public function isFinished():Bool
	{
		return Reflect.compareMethods(mainFunction, finish);
	}
}
