package haxegame.game.scenario;
typedef EventOption =
{
	var texts:Texts;
}
class EventOptionCreator
{
	public static inline function create(texts:Texts):EventOption
	{
		return {texts: texts};
	}
}

class Texts
{
	public var checked:Array<String>;
	public var fired:Array<String>;

	public function new()
	{
	}
}
