package com.dango_itimi.scenario.transition.screen_change;

class Fade
{
	public var opacity(default, null):Float;

	public static var DEFAULT_OPACITY_MAX = 100;
	public static var DEFAULT_OPACITY_MIN = 0;
	public static var DEFAULT_AMOUNT = 10;
	private var opacityMax:Float;
	private var opacityMin:Float;
	private var amount:Float;

	private var mainFunction:Void->Void;

	public function new(?amount:Null<Float>, ?opacityMax:Null<Float>, ?opacityMin:Null<Float>)
	{
		this.amount = (amount == null) ? DEFAULT_AMOUNT: amount;
		this.opacityMax = (opacityMax == null) ? DEFAULT_OPACITY_MAX: opacityMax;
		this.opacityMin = (opacityMin == null) ? DEFAULT_OPACITY_MIN: opacityMin;
	}

	//
	public function initializeToFadeIn()
	{
		opacity = opacityMax;
		mainFunction = fadeIn;
	}
	private function fadeIn()
	{
		opacity -= amount;
		if(opacity <= opacityMin){
			opacity = opacityMin;
			mainFunction = finish;
		}
	}

	//
	public function initializeToFadeOut()
	{
		opacity = opacityMin;
		mainFunction = fadeOut;
	}
	private function fadeOut()
	{
		opacity -= amount;
		if(opacity <= opacityMin){
			opacity = opacityMin;
			mainFunction = finish;
		}
	}

	//
	public function initializeToFadeCross()
	{
		opacity = opacityMax;
		mainFunction = fadeCrossOut;
	}
	private function fadeCrossOut()
	{
		opacity -= amount;
		if(opacity <= opacityMin){
			opacity = opacityMin;
			mainFunction = fadeIn;
		}
	}

	//
	public function run()
	{
		mainFunction();
	}
	private function finish(){}
	public function isFinished():Bool
		return Reflect.compareMethods(mainFunction, finish);
}

