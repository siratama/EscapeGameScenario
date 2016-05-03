package haxegame.game.screen_change;

import haxegame.dom.Root;
import jQuery.JQuery;
import haxegame.dom.JQueryElement;
import com.dango_itimi.scenario.transition.screen_change.Fade;
using haxegame.dom.JQueryElement;

class BlackScreen implements IUpdater
{
	private var jQueryElement:JQuery;
	public var fade(default, null):Fade;

	public function new()
	{
		jQueryElement = Root.instance.blackScreen;
		fade = new Fade(0.1, 1, 0);
	}
	public function update()
	{
		jQueryElement.setOpacity(fade.opacity);
	}
}
