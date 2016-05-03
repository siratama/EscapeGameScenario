package haxegame.dom;
import com.dango_itimi.geom.Point;
import jQuery.Event;
class Click
{
	private var position:Point;

	public function getPosition():Point
	{
		var n = position;
		position = null;
		return n;
	}
	public function new()
	{
		position = null;
		var root = Root.instance;
		var rootElement = root.jQueryElement;
		rootElement.click(function(event:Event){
			position = PointUtil.create(event.pageX - root.elementPositionX, event.pageY - root.elementPositionY);
		});
	}
}
