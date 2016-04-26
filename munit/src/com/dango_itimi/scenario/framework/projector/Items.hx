package com.dango_itimi.scenario.framework.projector;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.core.Scene;

class Items extends Scene
{
	@event public var sword(default, null):Item;
	@event public var shield(default, null):Item;

	public function new()
	{
		autoCreationEventInstanceClass = Item;
		super();

		sword.initialize("SWORD");
		shield.initialize("SHIELD");
	}
}

