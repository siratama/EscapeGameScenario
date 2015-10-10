package com.dango_itimi.escape_game.event;
import com.dango_itimi.escape_game.event.Story;

using com.dango_itimi.utils.MetaUtil;

class Book
{
	private var stories:Array<Story>;
	public var readingStory(default, null):Story;

	private static inline var META_STORY = "story";
	//
	// auto creation story instance
	// meta: @story
	// name rule: className:ClassName
	//
	//@story public var story1(default, null):Story1;
	private var extendedStoryClassPackagesString:String;

	public function new()
	{
		stories = [];

		createStoryAuto();
		checkStorySettingError();

		setBranch();
	}
	private function createStoryAuto()
	{
		setExtendedStoryClassPackagesString();

		var metaFieldSet = this.getMetaFieldsWithInstance(META_STORY);
		for(metaField in metaFieldSet){
			var metaFieldName = metaField.name;
			var smallFirstCharacter = metaFieldName.charAt(0);
			var largeFirstCharacter = smallFirstCharacter.toUpperCase();
			var storyClassName = largeFirstCharacter + metaFieldName.substring(1, metaFieldName.length);
			var storyClassPath = extendedStoryClassPackagesString + "." + storyClassName;
			var storyClass = Type.resolveClass(storyClassPath);

			var story:Story = Type.createInstance(storyClass, []);
			stories.push(story);
			Reflect.setProperty(this, metaFieldName, story);

			setStoryField(story);
			story.initialize();
		}
	}
	private function setExtendedStoryClassPackagesString()
	{
		if(extendedStoryClassPackagesString != null) return;

		var baseClass = Type.getClass(this);
		var packages = Type.getClassName(baseClass).split(".");
		packages.pop();
		extendedStoryClassPackagesString = packages.join(".");
	}
	private function setStoryField(story:Story){}

	private function checkStorySettingError()
	{
		for(story in stories){
			story.checkOverlappingArea();
			story.checkEventOrderError();
		}
	}

	private function setBranch() {}

	private function setReadingStory(story:Story)
	{
		story.enable(true);
		story.initializePriorityInArea();
		readingStory = story;
	}
	public function branchReadingStory(nextStory:Story)
	{
		readingStory.enable(false);
		setReadingStory(nextStory);
	}
	public function exchangeReadingStory(exchangedStory:Story)
	{
		readingStory.enable(false);
		exchangedStory.setPriorityInAreaWithExchangedReading();
		readingStory = exchangedStory;
	}
}

