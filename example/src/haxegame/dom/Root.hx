package haxegame.dom;
import jQuery.JQuery;
class Root
{
	@:allow(haxegame) private static var instance(get, null):Root;
	private static inline function get_instance():Root
		return instance == null ? instance = new Root(): instance;

	public var jQueryElement(default, null):JQuery;
	public var elementPositionX(default, null):Float;
	public var elementPositionY(default, null):Float;

	public var blackScreen(default, null):JQuery;
	public var subtitle(default, null):JQuery;

	public var clickArea(default, null):ClickArea;

	private function new()
	{
		jQueryElement = JQueryElement.createWithId("root");
		var position = jQueryElement.position();
		elementPositionX = position.left;
		elementPositionY = position.top;

		blackScreen = JQueryElement.createWithId("black_screen");
		subtitle = JQueryElement.createWithId("subtitle");

		clickArea = new ClickArea();
	}
}
class ClickArea
{
	public var jQueryElement(default, null):JQuery;
	public var scene1(default, null):Scene1;

	public function new()
	{
		jQueryElement = JQueryElement.createWithId("click_area_scene1");
		scene1 = new Scene1(jQueryElement);
	}
}
class Scene1
{
	public var jQueryElement(default, null):JQuery;
	public var table(default, null):JQuery;
	public var bed(default, null):JQuery;

	public function new(parentElement:JQuery)
	{
		jQueryElement = JQueryElement.createWithClass("scene1", parentElement);
		table = JQueryElement.createWithClass("table", jQueryElement);
		bed = JQueryElement.createWithClass("bed", jQueryElement);
	}
}
