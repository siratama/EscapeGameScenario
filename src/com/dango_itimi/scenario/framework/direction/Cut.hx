package com.dango_itimi.scenario.framework.direction;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.framework.item.Inventory.ItemChange;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.text.TextDisplayTymingInAction;

class Cut
{
	public var action:ActionInterface;
	public var text:String;
	public var textDisplayTymingInAction:TextDisplayTymingInAction;

	public var skipOperation:InteractionInterface;
	public var clapperboard:InteractionInterface;

	public function new()
	{
		textDisplayTymingInAction = TextDisplayTymingInAction.SAME;
	}
}
class ItemChangeCut extends Cut
{
	public var itemChange:ItemChange;
}
class EquipedIncorrectItemCut extends Cut
{
	public var incorrectItem:Item;
}
