package com.dango_itimi.scenario.framework.directionmap;
import com.dango_itimi.scenario.core.Event;
import com.dango_itimi.scenario.core.Scene;
import com.dango_itimi.scenario.core.Sequence;

class Chapter extends Sequence
{
	@scene public var scene1(default, null):Scene1;
}
class Scene1 extends Scene
{
	@event public var apple(default, null):Event;
}
