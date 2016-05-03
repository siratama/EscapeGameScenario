package haxegame.game.area;

import com.dango_itimi.geom.Rectangle;
using com.dango_itimi.utils.MetaUtil;

class EventAreas
{
	public var table:Rectangle;
	public var bed:Rectangle;

	public function new()
	{
	}

	/*
	//
	// dummy area data
	//
	@rect(0) public var table:Rectangle;
	@rect(1) public var bed:Rectangle;

	public function new()
	{
		var metaFieldSet = this.getMetaFieldsWithInstance("rect");
		for(metaField in metaFieldSet)
		{
			var rectangle = RectangleUtil.create(metaField.value[0] * 2, 0, 1, 1);
			Reflect.setProperty(this, metaField.name, rectangle);
		}
	}
	*/
}

