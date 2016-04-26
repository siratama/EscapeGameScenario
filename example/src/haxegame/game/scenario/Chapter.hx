package haxegame.game.scenario;
import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.scenario.core.Scene;
import com.dango_itimi.scenario.core.Sequence;

class Chapter extends Sequence
{
	@scene public var scene1(default, null):Scene1;
	@scene public var scene2(default, null):Scene2;
}
class Scene1 extends Scene
{
	@event public var apple(default, null):Event;
	@event public var orange(default, null):Event;
	@event public var banana(default, null):Event;
}
class Scene2 extends Scene
{
	@event public var table(default, null):Event;
	@event public var bed(default, null):Event;
	/*
	@event public var floor(default, null):Event;
	@event public var box(default, null):Event;
	@event public var window(default, null):Event;
	*/
}
