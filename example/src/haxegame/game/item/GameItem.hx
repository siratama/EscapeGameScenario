package haxegame.game.item;
import com.dango_itimi.escape_game.item.Item;
class GameItem extends Item
{
	public var name(default, null):String;
	public function initialize(name:String)
	{
		this.name = name;
	}
}
