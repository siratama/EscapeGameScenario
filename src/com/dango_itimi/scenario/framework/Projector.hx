package com.dango_itimi.scenario.framework;

import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.text.TextViewer;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.framework.direction.Cut;
import com.dango_itimi.scenario.framework.text.TextDisplayTymingInAction;

enum ProjectorEvent
{
	NONE;
	ITEM_CHANGE(itemChange:ItemChange);
	EQUIPED_INCORRECT_ITEM(item:Item);
	FINISH;
}

class Projector
{
	private var event:ProjectorEvent;
	public function getEvent():ProjectorEvent
	{
		var n = event;
		event = ProjectorEvent.NONE;
		return n;
	}

	private var mainFunction:Void->Void;
	private var nextFunctionAfterPlayText:Void->Void;
	private var textViewer:TextViewer;

	private var film:Film;
	private var cutIndex:Int;
	public var displayCut(default, null):Cut;

	public function new(textViewer:TextViewer)
	{
		this.textViewer = textViewer;
	}
	public function run()
	{
		mainFunction();
	}
	public function initialize(film:Film)
	{
		this.film = film;
		event = ProjectorEvent.NONE;
		cutIndex = 0;
		setDisplayCut();
	}
	private function setDisplayCut()
	{
		displayCut = film.cutSet[cutIndex];

		if(Std.is(displayCut, ItemChangeCut))
		{
			event = ProjectorEvent.ITEM_CHANGE(
				cast(displayCut, ItemChangeCut).itemChange
			);
		}
		else if(
			Std.is(film, EquipedIncorrectItemFilm) &&
			cast(film, EquipedIncorrectItemFilm).directionCutIndex == cutIndex
		){
			event = ProjectorEvent.EQUIPED_INCORRECT_ITEM(
				cast(film, EquipedIncorrectItemFilm).item
			);
		}

		if(displayCut.action != null && displayCut.text != null)
		{
			switch(displayCut.textDisplayTymingInAction)
			{
				case TextDisplayTymingInAction.BEFORE: initializeToPlayText(initializeToPlayAction);
				case TextDisplayTymingInAction.SAME: initializeToPlayActionAndText();
				case TextDisplayTymingInAction.AFTER: initializeToPlayAction();
			}
		}
		else if(displayCut.action == null)
		{
			initializeToPlayText(waitClapperboard);
		}
		else
		{
			initializeToPlayAction();
		}
	}

	//
	public function isPlaying():Bool
	{
		return
			Reflect.compareMethods(mainFunction, playText) ||
			Reflect.compareMethods(mainFunction, playAction) ||
			Reflect.compareMethods(mainFunction, playActionAndText);
	}

	//
	private function initializeToPlayText(nextFunctionAfterPlayText:Void->Void)
	{
		this.nextFunctionAfterPlayText = nextFunctionAfterPlayText;

		textViewer.initialize(displayCut.text);
		displayCut.skipOperation.initialize();
		mainFunction = playText;
	}
	private function playText()
	{
		textViewer.run();

		displayCut.skipOperation.run();
		if(displayCut.skipOperation.isExecuted())
			textViewer.orderSkip();

		if(textViewer.isFinished())
			nextFunctionAfterPlayText();
	}

	//
	private function initializeToPlayAction()
	{
		displayCut.action.initialize();
		displayCut.skipOperation.initialize();
		mainFunction = playAction;
	}
	private function playAction()
	{
		displayCut.action.run();

		displayCut.skipOperation.run();
		if(displayCut.skipOperation.isExecuted())
			displayCut.action.playDirect();

		if(displayCut.action.isFinished())
		{
			if(displayCut.text == null)
			{
				initializeToWaitClapperboard();
			}
			else
			{
				switch(displayCut.textDisplayTymingInAction)
				{
					case TextDisplayTymingInAction.AFTER: initializeToPlayText(initializeToWaitClapperboard);
					case _: initializeToWaitClapperboard();
				}
			}
		}
	}

	//
	private function initializeToPlayActionAndText()
	{
		displayCut.action.initialize();
		textViewer.initialize(displayCut.text);
		displayCut.skipOperation.initialize();
		mainFunction = playActionAndText;
	}
	private function playActionAndText()
	{
		displayCut.action.run();
		textViewer.run();

		displayCut.skipOperation.run();
		if(displayCut.skipOperation.isExecuted())
		{
			textViewer.orderSkip();
			displayCut.action.playDirect();
		}

		if(displayCut.action.isFinished() && textViewer.isFinished())
			initializeToWaitClapperboard();
	}

	//
	private function initializeToWaitClapperboard()
	{
		displayCut.clapperboard.initialize();
		mainFunction = waitClapperboard;
	}
	private function waitClapperboard()
	{
		displayCut.clapperboard.run();
		if(displayCut.clapperboard.isExecuted())
		{
			destroyToPlay();
		}
	}
	public function isWaitingClapperboard():Bool
	{
		return Reflect.compareMethods(mainFunction, waitClapperboard);
	}

	private function destroyToPlay()
	{
		if(++cutIndex < film.cutSet.length){
			setDisplayCut();
		}
		else{
			event = ProjectorEvent.FINISH;
			mainFunction = finish;
		}
	}
	private function finish(){}
}
