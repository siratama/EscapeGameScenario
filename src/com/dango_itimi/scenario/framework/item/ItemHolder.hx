package com.dango_itimi.scenario.framework.item;
import com.dango_itimi.scenario.framework.item.Item;

enum ItemChange
{
	PICKED_UP(items:Array<Item>);
	REMOVED(items:Array<Item>);
	EXCHANGED(pickedUp:Array<Item>, removed:Array<Item>);
}

class ItemHolder
{
	public var holder(default, null):Array<Item>;
	private var equipment:Item;

	public function new()
	{
		holder = [];
		equipment = null;
	}
	public function change(itemChange:ItemChange)
	{
		switch(itemChange)
		{
			case ItemChange.PICKED_UP(items): pickupSet(items);
			case ItemChange.REMOVED(items): removeSet(items);
			case ItemChange.EXCHANGED(pickedUp, removed): exchange(pickedUp, removed);
		}
	}
	public function pickup(item:Item)
	{
		holder.push(item);
	}
	public function pickupSet(itemSet:Array<Item>)
	{
		for(item in itemSet) pickup(item);
	}
	public function remove(item:Item)
	{
		var i = holder.length - 1;
		while(i > 0){

			if(holder[i] == item){
				holder.splice(i, 1);
				break;
			}
			i--;
		}
	}
	public function removeSet(itemSet:Array<Item>)
	{
		for(item in itemSet) remove(item);
	}
	public function exchange(pickedUp:Array<Item>, removed:Array<Item>)
	{
		pickupSet(pickedUp);
		removeSet(removed);
	}
	public function select(item:Item)
	{
		item.select();
		equipment = item;
	}
	public function unselect(item:Item)
	{
		item.unselect();
		equipment = null;
	}
	public function isSelected(item:Item):Bool
	{
		return (equipment != null) && (item == equipment);
	}
}
