package com.dango_itimi.scenario.core;

using com.dango_itimi.utils.MetaUtil;

class Sequence
{
	public var sceneSet(default, null):Array<Scene>;

	private static inline var META_SCENE = "scene";
	//
	// scene instance creation automatically
	// meta: @scene
	// name rule: className:ClassName
	//
	//@scene public var scene1(default, null):Scene1;
	private var extendedSceneClassPackagesString:String;

	public function new()
	{
		sceneSet = [];
		setExtendedSceneClassPackagesString();

		var metaFieldSet = this.getMetaFieldsWithInstance(META_SCENE);
		for(metaField in metaFieldSet)
		{
			var metaFieldName = metaField.name;
			var sceneClass = getSceneClass(metaFieldName);

			var scene:Scene = Type.createInstance(sceneClass, []);
			sceneSet.push(scene);
			Reflect.setProperty(this, metaFieldName, scene);
		}
	}
	private function setExtendedSceneClassPackagesString()
	{
		if(extendedSceneClassPackagesString != null) return;

		var baseClass = Type.getClass(this);
		var packages = Type.getClassName(baseClass).split(".");
		packages.pop();
		extendedSceneClassPackagesString = packages.join(".");
	}
	private function getSceneClass(metaFieldName:String)
	{
		var smallFirstCharacter = metaFieldName.charAt(0);
		var largeFirstCharacter = smallFirstCharacter.toUpperCase();
		var noteClassName = largeFirstCharacter + metaFieldName.substring(1, metaFieldName.length);
		var noteClassPath = extendedSceneClassPackagesString + "." + noteClassName;
		return Type.resolveClass(noteClassPath);
	}
}

class SequenceUtil
{
	public static function checkOnlyEnabledEventSet(sequence:Sequence, onlyEnabledEventSet:Array<Event>):Bool
	{
		var enabledEventSet = getEnabledEventSet(sequence);
		if(onlyEnabledEventSet.length != enabledEventSet.length) return false;

		for(checkedEvent in onlyEnabledEventSet)
		{
			var equals = false;
			for(enabledEvent in enabledEventSet)
			{
				if(checkedEvent != enabledEvent) continue;
				equals = true;
				break;
			}
			if(!equals) return false;
		}
		return true;
	}
	public static function getEnabledEventSet(sequence:Sequence):Array<Event>
	{
		var enabledEventSet = [];
		for(scene in sequence.sceneSet)
			for(event in scene.eventSet)
				if(event.enabled) enabledEventSet.push(event);

		return enabledEventSet;
	}
	public static function getEventMap(sequence:Sequence):Map<String, Event>
	{
		var eventMap = new Map();
		for(scene in sequence.sceneSet)
			for(event in scene.eventSet)
				eventMap[event.id] = event;

		return eventMap;
	}
}
