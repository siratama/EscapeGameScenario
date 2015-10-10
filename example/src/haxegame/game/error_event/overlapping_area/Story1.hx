package haxegame.game.error_event.overlapping_area;

import com.dango_itimi.geom.Rectangle;
import com.dango_itimi.escape_game.event.Story;
import com.dango_itimi.escape_game.event.Event;

class Story1 extends Story
{
	@event public var table(default, null):Event;
	@event public var bed(default, null):Event;
	@event public var floor(default, null):Event;
	@event public var window(default, null):Event;

	override private function setEvent()
	{
		//overlapping area
		var rectangle1 = RectangleUtil.create(0, 0, 10, 10);
		var rectangle2 = RectangleUtil.create(10, 0, 10, 10);

		//
		setUnqualifiedEvent(
			table, rectangle1,
			["thank you"]
		);

		//
		setDefaultEvent(
			bed, rectangle2,
			["good bye"], ["hello"]
		);
	}
}

