package com.dango_itimi.escape_game.book;
import com.dango_itimi.escape_game.book.Note;

using com.dango_itimi.utils.MetaUtil;

class Book
{
	private var notes:Array<Note>;
	public var readingNote(default, null):Note;

	private static inline var META_NOTE = "note";
	//
	// auto creation note instance
	// meta: @note
	// name rule: className:ClassName
	//
	//@note public var note1(default, null):Note1;
	private var extendedNoteClassPackagesString:String;

	public function new()
	{
		notes = [];
		setExtendedStoryClassPackagesString();

		var metaFieldSet = this.getMetaFieldsWithInstance(META_NOTE);
		for(metaField in metaFieldSet)
		{
			var metaFieldName = metaField.name;
			var noteClass = getNoteClass(metaFieldName);

			var note:Note = Type.createInstance(noteClass, []);
			notes.push(note);
			Reflect.setProperty(this, metaFieldName, note);
		}
	}
	private function setExtendedStoryClassPackagesString()
	{
		if(extendedNoteClassPackagesString != null) return;

		var baseClass = Type.getClass(this);
		var packages = Type.getClassName(baseClass).split(".");
		packages.pop();
		extendedNoteClassPackagesString = packages.join(".");
	}
	private function getNoteClass(metaFieldName:String)
	{
		var smallFirstCharacter = metaFieldName.charAt(0);
		var largeFirstCharacter = smallFirstCharacter.toUpperCase();
		var noteClassName = largeFirstCharacter + metaFieldName.substring(1, metaFieldName.length);
		var noteClassPath = extendedNoteClassPackagesString + "." + noteClassName;
		return Type.resolveClass(noteClassPath);
	}

	//
	public function checkSettingError()
	{
		for(note in notes){
			note.checkOverlappingArea();
			note.checkEventOrderError();
		}
	}

	//
	public function setReadingNote(note:Note)
	{
		note.enable(true);
		note.initializePriorityInArea();
		readingNote = note;
	}
	public function branchReadingNote(nextNote:Note)
	{
		readingNote.enable(false);
		setReadingNote(nextNote);
	}
	public function exchangeReadingNote(exchangedNote:Note)
	{
		readingNote.enable(false);
		exchangedNote.setPriorityInAreaWithExchangedReading();
		readingNote = exchangedNote;
	}
}

