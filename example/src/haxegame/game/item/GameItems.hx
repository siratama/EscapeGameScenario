package haxegame.game.item;
import com.dango_itimi.escape_game.item.Items;
class GameItems extends Items
{
	@:allow(haxegame) private static var instance(get, null):GameItems;
	private static inline function get_instance():GameItems
		return instance == null ? instance = new GameItems(): instance;

	@item public var normalSword(default, null):GameItem;
	@item public var normalSield(default, null):GameItem;

	private function new()
	{
		autoCreationItemInstanceClass = GameItem;
		super();

		normalSword.initialize("Normal Sword");
		normalSield.initialize("Normal Shield");
	}
}
