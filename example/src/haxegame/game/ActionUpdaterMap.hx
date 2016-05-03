package haxegame.game;
import com.dango_itimi.scenario.transition.direction.action.FadeAction;
import com.dango_itimi.scenario.framework.direction.action.ActionInterface;
class ActionUpdaterMap
{
	public var map(default, null):Map<ActionInterface, Array<IUpdater>>;

	public function new(actions:Actions, updaters:Updaters)
	{
		map = new Map();

		//
		actions.blackScreenFadeInAction = new FadeAction(updaters.blackScreen.fade, Mode.FADE_IN);
		map.set(actions.blackScreenFadeInAction, [updaters.blackScreen]);
	}
	public function update(action:ActionInterface)
	{
		if(map[action] == null) return;

		var updaterSet:Array<IUpdater> = map[action];
		for(updater in updaterSet)
		{
			updater.update();
		}
	}
}
