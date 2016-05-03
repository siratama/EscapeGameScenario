package haxegame.game.subtitle;

import haxegame.dom.Root;
import jQuery.JQuery;
import haxegame.dom.JQueryElement;
import com.dango_itimi.scenario.framework.text.Subtitle;
using haxegame.dom.JQueryElement;

class Translator implements IUpdater
{
	public var subtitle(default, null):Subtitle;
	private var jQueryElement:JQuery;

	private static inline var CHARACTER_DISPLAY_INTERVAL:Int = 1;
	private static inline var SOUND_TIMING:Int = 1;

	public function new()
	{
		subtitle = new Subtitle(CHARACTER_DISPLAY_INTERVAL, SOUND_TIMING);
		jQueryElement = Root.instance.subtitle;
	}
	public function update()
	{
		switch(subtitle.getEvent())
		{
			case TextViewerEvent.NONE: return;

			case TextViewerEvent.VIEW(text, isSoundTiming):
				jQueryElement.appendText(text);
				if(isSoundTiming){

				}
		}
	}
	public function reset()
	{
		jQueryElement.setText("");
	}
}
