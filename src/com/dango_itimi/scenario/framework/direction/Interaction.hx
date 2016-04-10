package com.dango_itimi.scenario.framework.direction;
class Interaction
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
		mainFunction = watch;
	}
	private function watch()
	{
		mainFunction = execute;
	}
	private function execute(){}
	public function isExecuted():Bool
	{
		return Reflect.compareMethods(mainFunction, execute);
	}
}
