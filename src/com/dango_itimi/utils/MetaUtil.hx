package com.dango_itimi.utils;

import haxe.rtti.Meta;
using com.dango_itimi.utils.MetaUtil;

class MetaField
{
	public var name(default, null):String;
	public var value(default, null):Array<Dynamic>;
	public function new(name:String, value:Array<Dynamic>)
	{
		this.name = name;
		this.value = value;
	}
}

class MetaUtil
{
	public static function getMetaFieldsWithInstance<T>(instance:T, metaLabel:String):Array<MetaField>
	{
		return Type.getClass(instance).getMetaFields(metaLabel);
	}
	public static function getMetaFields(cls:Class<Dynamic>, metaLabel:String):Array<MetaField>
	{
		var metaFieldSet:Array<MetaField> = [];

		var metaFields = Meta.getFields(cls);
		var fieldStrings = Reflect.fields(metaFields);
		for(fieldString in fieldStrings)
		{
			switch(metaFields.hasMetaData(fieldString, metaLabel))
			{
				case HasMetaDataResult.FALSE: continue;

				case HasMetaDataResult.TRUE(metaValues):
					var metaField = new MetaField(fieldString, metaValues);
					metaFieldSet.push(metaField);
			}
		}
		return metaFieldSet;
	}
	private static function hasMetaData(metaFields:Dynamic<Dynamic<Array<Dynamic>>>, fieldString:String, metaLabel:String):HasMetaDataResult
	{
		var fieldProperty = Reflect.getProperty(metaFields, fieldString);
		var metaLabels = Reflect.fields(fieldProperty);
		for(checkedMetaDataName in metaLabels)
		{
			if(checkedMetaDataName == metaLabel){
				var metaValues = Reflect.getProperty(fieldProperty, checkedMetaDataName);
				return HasMetaDataResult.TRUE(metaValues);
			}
		}
		return HasMetaDataResult.FALSE;
	}
}
private enum HasMetaDataResult
{
	TRUE(metaValues:Array<Dynamic>);
	FALSE;
}

