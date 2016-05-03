package com.dango_itimi.scenario.transition.direction.action;
import com.dango_itimi.scenario.transition.screen_change.Fade;
import com.dango_itimi.scenario.framework.direction.action.Action;

enum Mode
{
	FADE_IN;
	FADE_OUT;
	FADE_CROSS;
}

class FadeAction extends Action
{
	private var fade:Fade;
	private var mode:Mode;
	public function new(fade:Fade, mode:Mode, ?skipPlayRoopMaxCount:Null<Int>)
	{
		this.fade = fade;
		this.mode = mode;
		super(skipPlayRoopMaxCount);
	}
	override public function initialize()
	{
		switch(mode){
			case Mode.FADE_IN: fade.initializeToFadeIn();
			case Mode.FADE_OUT: fade.initializeToFadeOut();
			case Mode.FADE_CROSS: fade.initializeToFadeCross();
		}
		super.initialize();
	}
	override private function play()
	{
		fade.run();
		if(fade.isFinished())
			mainFunction = finish;
	}
}
