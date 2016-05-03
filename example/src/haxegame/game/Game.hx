package haxegame.game;

import com.dango_itimi.scenario.framework.direction.Film;
import haxegame.game.area.EventAreaConverter;
import com.dango_itimi.scenario.core.Scene;
import haxegame.game.area.EventAreas;
import haxegame.game.scenario.Items;
import com.dango_itimi.scenario.framework.Appraiser;
import haxegame.game.scenario.Writer;
import com.dango_itimi.scenario.framework.Director;
import com.dango_itimi.scenario.framework.area.AreaManager;
import com.dango_itimi.scenario.framework.direction.DirectionMap;
import com.dango_itimi.geom.Point;
import com.dango_itimi.scenario.framework.Projector;
import com.dango_itimi.scenario.framework.item.Inventory;
import haxegame.game.subtitle.Translator;

class Game
{
	private var mainFunction:Void->Void;
	private var actions:Actions;
	private var updaters:Updaters;
	private var actionUpdaterMap:ActionUpdaterMap;

	private var interactions:Interactions;
	private var translator:Translator;

	private var items:Items;
	private var inventory:Inventory;
	private var directionMap:DirectionMap;
	private var eventAreaConverter:EventAreaConverter;
	private var areaManager:AreaManager;

	private var director:Director;
	private var scenarioWriter:Writer;
	private var projector:Projector;

	private var clickPosition:Point;

	public function new()
	{
		translator = new Translator();

		actions = new Actions();
		updaters = new Updaters();
		actionUpdaterMap = new ActionUpdaterMap(actions, updaters);
		interactions = new Interactions();

		eventAreaConverter = new EventAreaConverter();

		items = new Items();
		inventory = new Inventory();
		directionMap = new DirectionMap();
		areaManager = new AreaManager();

		scenarioWriter = new Writer(items, inventory, directionMap, eventAreaConverter.eventAreas, areaManager, actions, interactions);

		director = new Director(inventory, directionMap, areaManager);
		projector = new Projector(translator.subtitle);

		Appraiser.checkUnsetDirection(scenarioWriter.chapter, directionMap);
		Appraiser.checkUnsetEventIdInAreaMap(scenarioWriter.chapter, areaManager);
		//Appraiser.checkSkipDirectionInAllAction(scenarioWriter.chapter, directionMap);

		initializeToWaitUserControl();
	}
	public function run()
	{
		mainFunction();
	}

	//
	public function operateClick(clickPosition:Point)
	{
		this.clickPosition = clickPosition;
	}
	private function initializeToWaitUserControl()
	{
		clickPosition = null;
		mainFunction = waitUserControl;
	}
	private function waitUserControl()
	{
		if(clickPosition == null) return;

		var scene:Scene = scenarioWriter.chapter.scene1; //test
		var film = director.progress(scene, clickPosition);
		if(film != null)
			initializeToProject(film);
	}
	private function initializeToProject(film:Film)
	{
		clickPosition = null;
		projector.initialize(film);
		mainFunction = project;
	}
	private function project()
	{
		checkClick();
		projector.run();
		update();

		switch(projector.getEvent())
		{
			case ProjectorEvent.NONE: return;
			case ProjectorEvent.CUT_START(cutStart):
				translator.reset();
				switch(cutStart)
				{
					case CutStart.ITEM_CHANGE(itemChange):
						inventory.change(itemChange);
						switch(itemChange)
						{
							case ItemChange.PICKED_UP(itemSet): //play sound
							case ItemChange.REMOVED(itemSet): //play sound
							case ItemChange.EXCHANGED(pickedUp, removed): //play sound
						}

					case CutStart.EQUIPED_INCORRECT_ITEM(incorrectItem): //play sound
					case CutStart.NONE: "";
				}

			case ProjectorEvent.FINISH:
				initializeToWaitUserControl();
		}
	}
	private function checkClick()
	{
		if(clickPosition == null) return;

		interactions.clickOperation.clicked = true;
	}
	private function update()
	{
		var cut = projector.displayCut;
		if(cut.action != null) actionUpdaterMap.update(cut.action);
		if(cut.text != null) translator.update();
	}

}
