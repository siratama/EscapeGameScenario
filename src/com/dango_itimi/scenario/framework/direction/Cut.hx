package com.dango_itimi.scenario.framework.direction;
import com.dango_itimi.scenario.framework.item.ItemHolder;
import com.dango_itimi.scenario.framework.item.ItemHolder.ItemChange;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.text.TextDisplayTymingInAction;

class Cut
{
	public var action:Action;
	public var text:String;
	public var textDisplayTymingInAction:TextDisplayTymingInAction;

	public var textSkipOperation:Interaction;
	public var clapperboard:Interaction;

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
