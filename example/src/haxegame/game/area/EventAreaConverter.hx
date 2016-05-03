package haxegame.game.area;
import haxegame.dom.JQueryElement;
import haxegame.dom.Root;
using haxegame.dom.JQueryElement;

class EventAreaConverter
{
	public var eventAreas(default, null):EventAreas;
	public function new()
	{
		eventAreas = new EventAreas();

		var clickArea = Root.instance.clickArea;
		eventAreas.table = clickArea.scene1.table.getRectangle();
		eventAreas.bed = clickArea.scene1.bed.getRectangle();
	}
}
