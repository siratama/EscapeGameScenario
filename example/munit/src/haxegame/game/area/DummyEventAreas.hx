package haxegame.game.area;

import haxe.rtti.Meta;
import com.dango_itimi.geom.Rectangle;
using com.dango_itimi.utils.MetaUtil;

class DummyEventAreas extends EventAreas
{

	private var count:Int;

	public function new()
	{
		super();

		count = 0;
		table = createDummyArea();
		bed = createDummyArea();
	}
	private function createDummyArea():Rectangle
	{
		return RectangleUtil.create(count * 2, 0, 1, 1);
	}
}

