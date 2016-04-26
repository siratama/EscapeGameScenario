package com.dango_itimi.scenario.framework.direction.action;
class Sleep extends Action
{
	private var sleepFrame:Int;
	private var count:Int;
	private var COUNT_DEFAULT_VALUE:Int = 0;
	public function new(sleepFrame:Int, ?skipPlayRoopMaxCount:Null<Int>)
	{
		if(sleepFrame <= COUNT_DEFAULT_VALUE) throw "set sleepFrame > COUNT_DEFAULT_VALUE";
		this.sleepFrame = sleepFrame;

		super(skipPlayRoopMaxCount);
	}
	override public function initialize()
	{
		count = COUNT_DEFAULT_VALUE;
		super.initialize();
	}
	override private function play()
	{
		if(count++ < sleepFrame) return;
		mainFunction = finish;
	}
}
