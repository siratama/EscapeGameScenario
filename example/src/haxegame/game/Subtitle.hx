package haxegame.game;

import com.dango_itimi.scenario.framework.text.TextViewer;

class Subtitle
{
	public var textViewer(default, null):TextViewer;

	private static inline var CHARACTER_DISPLAY_INTERVAL:Int = 3;
	private static inline var SOUND_TIMING:Int = 1;

	public function new()
	{
		textViewer = new TextViewer(CHARACTER_DISPLAY_INTERVAL, SOUND_TIMING);
	}
	public function run()
	{
		switch(textViewer.getEvent())
		{
			case TextViewerEvent.NONE: return;
			case TextViewerEvent.VIEW(text, isSoundTiming):
				text;
				if(isSoundTiming){

				}
		}
		
	}
}
