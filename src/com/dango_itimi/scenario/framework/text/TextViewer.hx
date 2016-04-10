package com.dango_itimi.scenario.framework.text;

enum TextViewerEvent
{
	NONE;
	VIEW(text:String, isSoundTiming:Bool);
}

class TextViewer
{
	private var event:TextViewerEvent;
	public function getEvent():TextViewerEvent {
		var n = event;
		event = TextViewerEvent.NONE;
		return n;
	}

	private var mainFunction:Void->Void;
	private var text:String;
	private var textIndex:Int;

	//
	public var characterDisplayInterval(null, set):Int;
	public function set_characterDisplayInterval(characterDisplayInterval:Int):Int
		return this.characterDisplayInterval = characterDisplayInterval;

	private var characterDisplayIntervalCount:Int;
	private static inline var CHARACTER_DISPLAY_INTERVAL_COUNT_DEFAULT_VALUE = -1;

	//each character
	public var soundTiming(null, set):Int;
	public function set_soundTiming(soundTiming:Int):Int
		return this.soundTiming = soundTiming;

	private var soundTimingCount:Int;
	
	private var skipOrder:Bool;

	public function new(characterDisplayInterval:Int, soundTiming:Int)
	{
		this.characterDisplayInterval = characterDisplayInterval;
		this.soundTiming = soundTiming;
	}
	public function run()
	{
		mainFunction();
	}
	public function initialize(text:String)
	{
		this.text = text;
		event = TextViewerEvent.NONE;

		textIndex = 0;
		characterDisplayIntervalCount = CHARACTER_DISPLAY_INTERVAL_COUNT_DEFAULT_VALUE;
		soundTimingCount = 0;
		skipOrder = false;
		mainFunction = play;
	}
	private function play()
	{
		if(skipOrder)
		{
			var text = text.substr(textIndex);
			event = TextViewerEvent.VIEW(text, true);
			mainFunction = finish;
		}
		else
		{
			if(++characterDisplayIntervalCount < characterDisplayInterval) return;
			characterDisplayIntervalCount = CHARACTER_DISPLAY_INTERVAL_COUNT_DEFAULT_VALUE;

			var character = text.charAt(textIndex);
			textIndex++;

			var isSoundTiming = false;
			if(++soundTimingCount >= soundTiming){
				isSoundTiming = true;
				soundTimingCount = 0;
			}
			event = TextViewerEvent.VIEW(character, isSoundTiming);

			if(textIndex >= text.length)
				mainFunction = finish;
		}
	}
	public function orderSkip()
	{
		skipOrder = true;
	}

	private function finish(){}
	public function isFinished():Bool
		return Reflect.compareMethods(mainFunction, finish);
}
