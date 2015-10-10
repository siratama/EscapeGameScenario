package com.dango_itimi.escape_game;
import com.dango_itimi.escape_game.item.Item;

class ItemHolder
{
	public var set(default, null):Array<Item>;

	public function new()
	{
		set = [];
	}
	public function removeItems(removedItems:Array<Item>)
	{
		for (removedItem in removedItems)
		{
			var i = 0;
			while(i < set.length)
			{
				var item = set[i];
				if(item == removedItem){
					set.splice(i, 1);
					i--;
				}
				i++;
			}
		}
	}
	public function addItems(gottenItems:Array<Item>)
	{
		set = set.concat(gottenItems);
	}
}
