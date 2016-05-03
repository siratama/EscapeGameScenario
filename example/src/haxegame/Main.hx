package haxegame;
import haxegame.dom.Click;
import haxegame.game.Game;
import haxe.Timer;
import jQuery.JQuery;
class Main
{
	public static var FPS = 24;
	private var game:Game;
	private var click:Click;
	private var timer:Timer;

	public static function main()
	{
		new JQuery(function(){
			new Main();
		});
	}
	public function new()
	{
		click = new Click();
		game = new Game();
		timer = new Timer(Std.int(1 / FPS * 1000));
		timer.run = function(){ run(); };
	}
	private function run()
	{
		game.run();

		var clickPosition = click.getPosition();
		if(clickPosition != null){
			game.operateClick(clickPosition);
		}
	}
}
