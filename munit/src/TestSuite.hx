import massive.munit.TestSuite;

import com.dango_itimi.scenario.framework.areamap.Test;
import com.dango_itimi.scenario.framework.directionmap.Test;
import com.dango_itimi.scenario.framework.director.Test;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(com.dango_itimi.scenario.framework.areamap.Test);
		add(com.dango_itimi.scenario.framework.directionmap.Test);
		add(com.dango_itimi.scenario.framework.director.Test);
	}
}
