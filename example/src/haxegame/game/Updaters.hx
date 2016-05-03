package haxegame.game;
import haxegame.game.screen_change.BlackScreen;
class Updaters
{
	public var blackScreen(default, null):BlackScreen;

	public function new()
	{
		blackScreen = new BlackScreen();
	}
}
