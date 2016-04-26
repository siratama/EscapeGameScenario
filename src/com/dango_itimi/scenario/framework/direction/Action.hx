package com.dango_itimi.scenario.framework.direction;

/*
class ActionEvent
{
}
*/

class Action implements ActionInterface
{
	private static inline var SKIP_PLAY_ROOP_MAX_COUNT:Int = 1000;
	private var skipPlayRoopMaxCount:Int;
	private var mainFunction:Void->Void;

	/*
	private var event:ActionEvent;
	public function getEvent():ActionEvent
	{
		var n = event;
		event = null;
		return event;
	}
	*/

	public function new(?skipPlayRoopMaxCount:Null<Int>)
	{
		this.skipPlayRoopMaxCount =
			(skipPlayRoopMaxCount != null) ? skipPlayRoopMaxCount: SKIP_PLAY_ROOP_MAX_COUNT;
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
	public function playDirect():Bool
	{
		var roopFrame = SKIP_PLAY_ROOP_MAX_COUNT;
		while(roopFrame >= 0)
		{
			run();
			if(isFinished()) break;

			roopFrame--;
		}
		return (roopFrame >= 0);
	}

	private function finish(){}
	public function isFinished():Bool
	{
		return Reflect.compareMethods(mainFunction, finish);
	}
}