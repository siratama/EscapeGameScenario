package com.dango_itimi.escape_game.item;

import com.dango_itimi.escape_game.item.Item;
using com.dango_itimi.utils.MetaUtil;

class Items
{
	public static inline var META_ITEM = "item";
	private var autoCreationItemInstanceClass:Class<Item>;
	//
	// auto creation event instance
	// meta: @item
	//
	//@item public var sword(default, null):Item;

	private var set:Array<Item>;

	public function new()
	{
		set = [];
		createItemAuto();
	}
	public function createItemAuto()
	{
		if(autoCreationItemInstanceClass == null) autoCreationItemInstanceClass = Item;

		var metaFieldSet = this.getMetaFieldsWithInstance(META_ITEM);
		for(metaField in metaFieldSet){
			var event = Type.createInstance(autoCreationItemInstanceClass, []);
			set.push(event);
			Reflect.setProperty(this, metaField.name, event);
		}
	}
}
