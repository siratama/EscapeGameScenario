package com.dango_itimi.scenario.framework;

import com.dango_itimi.scenario.framework.direction.Film;
import com.dango_itimi.scenario.framework.item.Item;
import com.dango_itimi.scenario.framework.text.Subtitle;
import com.dango_itimi.scenario.framework.item.Inventory;
import com.dango_itimi.scenario.framework.direction.Cut;
import com.dango_itimi.scenario.framework.text.SubtitleDisplayTymingInAction;

enum ProjectorEvent
{
	NONE;
	CUT_START(cutStart:CutStart);
	FINISH;
}
enum CutStart
{
	NONE;
	ITEM_CHANGE(itemChange:ItemChange);
	EQUIPED_INCORRECT_ITEM(item:Item);
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
	private var subtitle:Subtitle;

	private var film:Film;
	private var cutIndex:Int;
	public var displayCut(default, null):Cut;

	public function new(subtitle:Subtitle)
	{
		this.subtitle = subtitle;
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

		var cutStartEvent:CutStart;
		if(Std.is(displayCut, ItemChangeCut))
		{
			cutStartEvent = CutStart.ITEM_CHANGE(
				cast(displayCut, ItemChangeCut).itemChange
			);
		}
		else if(
			Std.is(film, EquipedIncorrectItemFilm) &&
			cast(film, EquipedIncorrectItemFilm).directionCutIndex == cutIndex
		){
			cutStartEvent = CutStart.EQUIPED_INCORRECT_ITEM(
				cast(film, EquipedIncorrectItemFilm).item
			);
		}
		else
			cutStartEvent = CutStart.NONE;

		event = ProjectorEvent.CUT_START(cutStartEvent);

		if(displayCut.action != null && displayCut.text != null)
		{
			switch(displayCut.textDisplayTymingInAction)
			{
				case SubtitleDisplayTymingInAction.BEFORE: initializeToPlayText(initializeToPlayAction);
				case SubtitleDisplayTymingInAction.SAME: initializeToPlayActionAndText();
				case SubtitleDisplayTymingInAction.AFTER: initializeToPlayAction();
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

		subtitle.initialize(displayCut.text);
		displayCut.skipOperation.initialize();
		mainFunction = playText;
	}
	private function playText()
	{
		subtitle.run();

		displayCut.skipOperation.run();
		if(displayCut.skipOperation.isExecuted())
			subtitle.orderSkip();

		if(subtitle.isFinished())
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
					case SubtitleDisplayTymingInAction.AFTER: initializeToPlayText(initializeToWaitClapperboard);
					case _: initializeToWaitClapperboard();
				}
			}
		}
	}

	//
	private function initializeToPlayActionAndText()
	{
		displayCut.action.initialize();
		subtitle.initialize(displayCut.text);
		displayCut.skipOperation.initialize();
		mainFunction = playActionAndText;
	}
	private function playActionAndText()
	{
		displayCut.action.run();
		subtitle.run();

		displayCut.skipOperation.run();
		if(displayCut.skipOperation.isExecuted())
		{
			subtitle.orderSkip();
			displayCut.action.playDirect();
		}

		if(displayCut.action.isFinished() && subtitle.isFinished())
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

