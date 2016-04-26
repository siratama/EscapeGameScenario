package com.dango_itimi.scenario.framework.direction;

import com.dango_itimi.scenario.framework.direction.Film;
class Direction
{
	public var checkedFilm(default, null):CheckedFilm;
	public var firedFilm(default, null):FiredFilm;
	public var equipedIncorrectItemFilm(default, null):EquipedIncorrectItemFilm;

	public function new(firedFilm:FiredFilm, checkedFilm:CheckedFilm, equipedIncorrectItemFilm:EquipedIncorrectItemFilm)
	{
		this.firedFilm = firedFilm;
		this.checkedFilm = checkedFilm;
		this.equipedIncorrectItemFilm = equipedIncorrectItemFilm;
	}
}

