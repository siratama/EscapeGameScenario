package com.dango_itimi.scenario.framework.direction;
import com.dango_itimi.scenario.framework.direction.Cut.ItemChangeCut;
import com.dango_itimi.scenario.framework.item.Item;

class Film
{
	public var cutSet(default, null):Array<Cut>;

	@:allow(com.dango_itimi.scenario.framework.direction.Film)
	private function new(cut:Cut)
	{
		cutSet = [];
		add(cut);
	}
	public function add(cut:Cut)
	{
		cutSet.push(cut);
	}
}
class FiredFilm extends Film
{
	public function new(cut:Cut)
	{
		super(cut);
	}
}
class CheckedFilm extends Film
{
	public function new(cut:Cut)
	{
		super(cut);
	}
	override public function add(cut:Cut)
	{
		if(Std.is(cut, ItemChangeCut)){
			throw "You can't set ItemChangeCut to CheckedFilm.";
		}
		super.add(cut);
	}
}
class EquipedIncorrectItemFilm extends Film
{
	public var item(default, null):Item;
	public var directionCutIndex(default, null):Int;

	public function new(cut:Cut, equipedIncorrectItem:Item, equipedIncorrectItemCutIndex:Int)
	{
		this.item = equipedIncorrectItem;
		this.directionCutIndex = equipedIncorrectItemCutIndex;

		super(cut);
	}
	override public function add(cut:Cut)
	{
		if(Std.is(cut, ItemChangeCut)){
			throw "You can't set ItemChangeCut to EquipedIncorrectItemFilm.";
		}
		super.add(cut);
	}
}