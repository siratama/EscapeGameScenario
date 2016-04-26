package com.dango_itimi.scenario.framework;
import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.scenario.framework.area.AreaManager;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.scenario.core.Sequence;

using com.dango_itimi.scenario.framework.Appraiser;

class Appraiser
{
	public static function checkUnsetDirection(sequence:Sequence, directionMap:DirectionMap)
	{
		var unsetEventIds = [];
		for(scene in sequence.sceneSet)
		{
			for(event in scene.eventSet)
			{
				var direction = directionMap.get(event);
				if(direction == null){
					unsetEventIds.push(event.id);
				}
			}
		}
		if(unsetEventIds.length == 0) return;

		throw "Unset Direction:\n" + unsetEventIds.join("\n");
	}
	public static function checkUnsetEventIdInAreaMap(sequence:Sequence, areaManager:AreaManager)
	{
		var unsetEventIdsInAreaMap = [];
		for(scene in sequence.sceneSet)
		{
			var unsetEvents:Array<Event> = [];
			for(event in scene.eventSet){
				if(!areaManager.isIncludedInAreaMap(event)) unsetEvents.push(event);
			}
			if(unsetEvents.length == 0) continue;

			for(event in unsetEvents){
				unsetEventIdsInAreaMap.push(event.id);
			}
		}
		if(unsetEventIdsInAreaMap.length == 0) return;

		throw "Unset Event ID List In AreaMap:\n" + unsetEventIdsInAreaMap.join("\n");
	}

	//
	// Processing time sometimes becomes very long for this method.
	// Use by test.
	//
	public static function checkSkipDirectionInAllAction(sequence:Sequence, directionMap:DirectionMap)
	{
		var errorCutEventMessage = [];
		for(scene in sequence.sceneSet)
		{
			for(event in scene.eventSet)
			{
				var direction = directionMap.get(event);
				var filmErrorMessageSet = [];
				var errorCutIndexSet:Array<Int>;

				errorCutIndexSet = getErrorCutIndexSet(direction.firedFilm);
				filmErrorMessageSet.setErrorCutMessage("firedFilm", errorCutIndexSet);

				errorCutIndexSet = getErrorCutIndexSet(direction.checkedFilm);
				filmErrorMessageSet.setErrorCutMessage("checkedFilm", errorCutIndexSet);

				errorCutIndexSet = getErrorCutIndexSet(direction.equipedIncorrectItemFilm);
				filmErrorMessageSet.setErrorCutMessage("equipedIncorrectItemFilm", errorCutIndexSet);

				if(filmErrorMessageSet.length == 0) continue;

				var message = event.id + ": Skip play frame count reached the limit.\n" + filmErrorMessageSet.join("\n");
				errorCutEventMessage.push(message);
			}
		}
		if(errorCutEventMessage.length > 0)
			throw errorCutEventMessage.join("\n");
	}
	private static function getErrorCutIndexSet(film:Film):Array<Int>
	{
		if(film == null) return null;

		var errorCutIndexSet = [];
		for(i in 0...film.cutSet.length)
		{
			var cut = film.cutSet[i];
			if(cut.action == null) continue;

			cut.action.initialize();
			if(!cut.action.playDirect()){
				errorCutIndexSet.push(i);
			}
		}
		return errorCutIndexSet;
	}
	private static function setErrorCutMessage(errorMessageSet:Array<String>, filmName:String, errorCutIndexSet:Array<Int>)
	{
		if(errorCutIndexSet == null || errorCutIndexSet.length == 0) return;

		var message = filmName + ": " + errorCutIndexSet.join(",");
		errorMessageSet.push(message);
	}
}