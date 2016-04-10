import massive.munit.TestSuite;

import haxegame.game.GameTest;
import haxegame.game.scenario_error.event_order_error.EventOrderErrorTest;
import haxegame.game.scenario_error.overlapping_area.OverlappingAreaTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(haxegame.game.GameTest);
		add(haxegame.game.scenario_error.event_order_error.EventOrderErrorTest);
		add(haxegame.game.scenario_error.overlapping_area.OverlappingAreaTest);
	}
}
