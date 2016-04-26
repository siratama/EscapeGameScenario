package com.dango_itimi.scenario.framework.item;
import com.dango_itimi.scenario.framework.item.Item;

enum ItemChange
{
	PICKED_UP(itemSet:Array<Item>);
	REMOVED(itemSet:Array<Item>);
	EXCHANGED(pickedUp:Array<Item>, removed:Array<Item>);
}

class Inventory
{
	public var set(default, null):Array<Item>;
	private var equipment:Item;

	public function new()
	{
		set = [];
		equipment = null;
	}
	public function change(itemChange:ItemChange)
	{
		switch(itemChange)
		{
			case ItemChange.PICKED_UP(itemSet): pickupSet(itemSet);
			case ItemChange.REMOVED(itemSet): removeSet(itemSet);
			case ItemChange.EXCHANGED(pickedUp, removed): exchange(pickedUp, removed);
		}
	}
	public function pickup(item:Item)
	{
		set.push(item);
	}
	public function pickupSet(itemSet:Array<Item>)
	{
		for(item in itemSet) pickup(item);
	}
	public function remove(item:Item)
	{
		var i = set.length - 1;
		while(i >= 0){

			if(set[i] == item){
				set.splice(i, 1);
				break;
			}
			i--;
		}
		if(i <= -1) throw "You do not have " + item.id;
	}
	public function removeSet(itemSet:Array<Item>)
	{
		for(item in itemSet) remove(item);
	}
	public function exchange(pickedUp:Array<Item>, removed:Array<Item>)
	{
		removeSet(removed);
		pickupSet(pickedUp);
	}
	public function select(item:Item)
	{
		item.select();
		equipment = item;
	}
	public function selectFromIndex(index:Int)
	{
		select(set[index]);
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
