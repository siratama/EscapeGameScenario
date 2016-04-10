package com.dango_itimi.scenario.core;

using com.dango_itimi.utils.MetaUtil;

class Sequence
{
	private var scenes:Array<Scene>;

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
		scenes = [];
		setExtendedSceneClassPackagesString();

		var metaFieldSet = this.getMetaFieldsWithInstance(META_SCENE);
		for(metaField in metaFieldSet)
		{
			var metaFieldName = metaField.name;
			var sceneClass = getSceneClass(metaFieldName);

			var scene:Scene = Type.createInstance(sceneClass, []);
			scenes.push(scene);
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
