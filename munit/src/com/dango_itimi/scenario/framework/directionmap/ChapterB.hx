package com.dango_itimi.scenario.framework.directionmap;

import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.scenario.core.Scene;
import com.dango_itimi.scenario.core.Sequence;

class ChapterB extends Sequence
{
	@scene public var sceneB1(default, null):SceneB1;
}
class SceneB1 extends Scene
{
	@event public var apple(default, null):Event;
	@event public var orange(default, null):Event;
	@event public var banana(default, null):Event;
}
