import massive.munit.TestSuite;

import haxegame.game.BookReaderTest;
import haxegame.game.error_event.event_order_error.GameBookTest;
import haxegame.game.error_event.overlapping_area.GameBookTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(haxegame.game.BookReaderTest);
		add(haxegame.game.error_event.event_order_error.GameBookTest);
		add(haxegame.game.error_event.overlapping_area.GameBookTest);
	}
}
