(function (console, $global) { "use strict";
var $hxClasses = {},$estr = function() { return js_Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
$hxClasses["HxOverrides"] = HxOverrides;
HxOverrides.__name__ = ["HxOverrides"];
HxOverrides.strDate = function(s) {
	var _g = s.length;
	switch(_g) {
	case 8:
		var k = s.split(":");
		var d = new Date();
		d.setTime(0);
		d.setUTCHours(k[0]);
		d.setUTCMinutes(k[1]);
		d.setUTCSeconds(k[2]);
		return d;
	case 10:
		var k1 = s.split("-");
		return new Date(k1[0],k1[1] - 1,k1[2],0,0,0);
	case 19:
		var k2 = s.split(" ");
		var y = k2[0].split("-");
		var t = k2[1].split(":");
		return new Date(y[0],y[1] - 1,y[2],t[0],t[1],t[2]);
	default:
		throw new js__$Boot_HaxeError("Invalid date format : " + s);
	}
};
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var List = function() {
	this.length = 0;
};
$hxClasses["List"] = List;
List.__name__ = ["List"];
List.prototype = {
	add: function(item) {
		var x = [item];
		if(this.h == null) this.h = x; else this.q[1] = x;
		this.q = x;
		this.length++;
	}
	,__class__: List
};
Math.__name__ = ["Math"];
var Reflect = function() { };
$hxClasses["Reflect"] = Reflect;
Reflect.__name__ = ["Reflect"];
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		if (e instanceof js__$Boot_HaxeError) e = e.val;
		return null;
	}
};
Reflect.getProperty = function(o,field) {
	var tmp;
	if(o == null) return null; else if(o.__properties__ && (tmp = o.__properties__["get_" + field])) return o[tmp](); else return o[field];
};
Reflect.setProperty = function(o,field,value) {
	var tmp;
	if(o.__properties__ && (tmp = o.__properties__["set_" + field])) o[tmp](value); else o[field] = value;
};
Reflect.callMethod = function(o,func,args) {
	return func.apply(o,args);
};
Reflect.fields = function(o) {
	var a = [];
	if(o != null) {
		var hasOwnProperty = Object.prototype.hasOwnProperty;
		for( var f in o ) {
		if(f != "__id__" && f != "hx__closures__" && hasOwnProperty.call(o,f)) a.push(f);
		}
	}
	return a;
};
Reflect.isFunction = function(f) {
	return typeof(f) == "function" && !(f.__name__ || f.__ename__);
};
Reflect.compareMethods = function(f1,f2) {
	if(f1 == f2) return true;
	if(!Reflect.isFunction(f1) || !Reflect.isFunction(f2)) return false;
	return f1.scope == f2.scope && f1.method == f2.method && f1.method != null;
};
Reflect.deleteField = function(o,field) {
	if(!Object.prototype.hasOwnProperty.call(o,field)) return false;
	delete(o[field]);
	return true;
};
var Std = function() { };
$hxClasses["Std"] = Std;
Std.__name__ = ["Std"];
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
Std.parseFloat = function(x) {
	return parseFloat(x);
};
var StringBuf = function() {
	this.b = "";
};
$hxClasses["StringBuf"] = StringBuf;
StringBuf.__name__ = ["StringBuf"];
StringBuf.prototype = {
	add: function(x) {
		this.b += Std.string(x);
	}
	,__class__: StringBuf
};
var StringTools = function() { };
$hxClasses["StringTools"] = StringTools;
StringTools.__name__ = ["StringTools"];
StringTools.fastCodeAt = function(s,index) {
	return s.charCodeAt(index);
};
var ValueType = $hxClasses["ValueType"] = { __ename__ : ["ValueType"], __constructs__ : ["TNull","TInt","TFloat","TBool","TObject","TFunction","TClass","TEnum","TUnknown"] };
ValueType.TNull = ["TNull",0];
ValueType.TNull.toString = $estr;
ValueType.TNull.__enum__ = ValueType;
ValueType.TInt = ["TInt",1];
ValueType.TInt.toString = $estr;
ValueType.TInt.__enum__ = ValueType;
ValueType.TFloat = ["TFloat",2];
ValueType.TFloat.toString = $estr;
ValueType.TFloat.__enum__ = ValueType;
ValueType.TBool = ["TBool",3];
ValueType.TBool.toString = $estr;
ValueType.TBool.__enum__ = ValueType;
ValueType.TObject = ["TObject",4];
ValueType.TObject.toString = $estr;
ValueType.TObject.__enum__ = ValueType;
ValueType.TFunction = ["TFunction",5];
ValueType.TFunction.toString = $estr;
ValueType.TFunction.__enum__ = ValueType;
ValueType.TClass = function(c) { var $x = ["TClass",6,c]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; };
ValueType.TEnum = function(e) { var $x = ["TEnum",7,e]; $x.__enum__ = ValueType; $x.toString = $estr; return $x; };
ValueType.TUnknown = ["TUnknown",8];
ValueType.TUnknown.toString = $estr;
ValueType.TUnknown.__enum__ = ValueType;
var Type = function() { };
$hxClasses["Type"] = Type;
Type.__name__ = ["Type"];
Type.getClassName = function(c) {
	var a = c.__name__;
	if(a == null) return null;
	return a.join(".");
};
Type.getEnumName = function(e) {
	var a = e.__ename__;
	return a.join(".");
};
Type.resolveClass = function(name) {
	var cl = $hxClasses[name];
	if(cl == null || !cl.__name__) return null;
	return cl;
};
Type.resolveEnum = function(name) {
	var e = $hxClasses[name];
	if(e == null || !e.__ename__) return null;
	return e;
};
Type.createInstance = function(cl,args) {
	var _g = args.length;
	switch(_g) {
	case 0:
		return new cl();
	case 1:
		return new cl(args[0]);
	case 2:
		return new cl(args[0],args[1]);
	case 3:
		return new cl(args[0],args[1],args[2]);
	case 4:
		return new cl(args[0],args[1],args[2],args[3]);
	case 5:
		return new cl(args[0],args[1],args[2],args[3],args[4]);
	case 6:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5]);
	case 7:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6]);
	case 8:
		return new cl(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7]);
	default:
		throw new js__$Boot_HaxeError("Too many arguments");
	}
	return null;
};
Type.createEmptyInstance = function(cl) {
	function empty() {}; empty.prototype = cl.prototype;
	return new empty();
};
Type.createEnum = function(e,constr,params) {
	var f = Reflect.field(e,constr);
	if(f == null) throw new js__$Boot_HaxeError("No such constructor " + constr);
	if(Reflect.isFunction(f)) {
		if(params == null) throw new js__$Boot_HaxeError("Constructor " + constr + " need parameters");
		return Reflect.callMethod(e,f,params);
	}
	if(params != null && params.length != 0) throw new js__$Boot_HaxeError("Constructor " + constr + " does not need parameters");
	return f;
};
Type.getEnumConstructs = function(e) {
	var a = e.__constructs__;
	return a.slice();
};
Type["typeof"] = function(v) {
	var _g = typeof(v);
	switch(_g) {
	case "boolean":
		return ValueType.TBool;
	case "string":
		return ValueType.TClass(String);
	case "number":
		if(Math.ceil(v) == v % 2147483648.0) return ValueType.TInt;
		return ValueType.TFloat;
	case "object":
		if(v == null) return ValueType.TNull;
		var e = v.__enum__;
		if(e != null) return ValueType.TEnum(e);
		var c = js_Boot.getClass(v);
		if(c != null) return ValueType.TClass(c);
		return ValueType.TObject;
	case "function":
		if(v.__name__ || v.__ename__) return ValueType.TObject;
		return ValueType.TFunction;
	case "undefined":
		return ValueType.TNull;
	default:
		return ValueType.TUnknown;
	}
};
var com_dango_$itimi_geom_PointUtil = function() { };
$hxClasses["com.dango_itimi.geom.PointUtil"] = com_dango_$itimi_geom_PointUtil;
com_dango_$itimi_geom_PointUtil.__name__ = ["com","dango_itimi","geom","PointUtil"];
com_dango_$itimi_geom_PointUtil.xy = function(point,x,y) {
	point.x = x;
	point.y = y;
};
com_dango_$itimi_geom_PointUtil.convert = function(pt) {
	return { x : pt.x, y : pt.y};
};
com_dango_$itimi_geom_PointUtil.create = function(x,y) {
	return { x : x, y : y};
};
com_dango_$itimi_geom_PointUtil.clone = function(p0) {
	return { x : p0.x, y : p0.y};
};
com_dango_$itimi_geom_PointUtil.lengthSqr = function(p0) {
	return p0.x * p0.x + p0.y * p0.y;
};
com_dango_$itimi_geom_PointUtil.getLength = function(p0) {
	return Math.sqrt(p0.x * p0.x + p0.y * p0.y);
};
com_dango_$itimi_geom_PointUtil.angle = function(p0) {
	return Math.atan2(p0.y,p0.x);
};
com_dango_$itimi_geom_PointUtil.angleBetween = function(p0,p1) {
	return Math.atan2(p0.y - p1.y,p0.x - p1.x);
};
com_dango_$itimi_geom_PointUtil.distanceSqr = function(p0,p1) {
	var x = p0.x - p1.x;
	var y = p0.y - p1.y;
	return x * x + y * y;
};
com_dango_$itimi_geom_PointUtil.distance = function(p0,p1) {
	var x = p0.x - p1.x;
	var y = p0.y - p1.y;
	return Math.sqrt(x * x + y * y);
};
com_dango_$itimi_geom_PointUtil.dot = function(p0,p1) {
	return p0.x * p1.x + p0.y * p1.y;
};
com_dango_$itimi_geom_PointUtil.cross = function(p0,p1) {
	return p0.x * p1.y - p0.y * p1.x;
};
com_dango_$itimi_geom_PointUtil.equals = function(p0,p1) {
	return p0.x == p1.x && p0.y == p1.y;
};
com_dango_$itimi_geom_PointUtil.nearEquals = function(p0,p1,t) {
	if(t == null) t = 0.0;
	var x = Math.abs(p0.x - p1.x);
	var y = Math.abs(p0.y - p1.y);
	return x <= t && y <= t;
};
com_dango_$itimi_geom_PointUtil.gt = function(p0,p1) {
	return p0.x > p1.x && p0.y > p1.y;
};
com_dango_$itimi_geom_PointUtil.gte = function(p0,p1) {
	return p0.x >= p1.x && p0.y >= p1.y;
};
com_dango_$itimi_geom_PointUtil.lt = function(p0,p1) {
	return p0.x < p1.x && p0.y < p1.y;
};
com_dango_$itimi_geom_PointUtil.lte = function(p0,p1) {
	return p0.x <= p1.x && p0.y <= p1.y;
};
com_dango_$itimi_geom_PointUtil.polar = function(l,a) {
	return { x : l * Math.cos(a), y : l * Math.sin(a)};
};
com_dango_$itimi_geom_PointUtil.add = function(p0,p1) {
	return { x : p0.x + p1.x, y : p0.y + p1.y};
};
com_dango_$itimi_geom_PointUtil.sub = function(p0,p1) {
	return { x : p0.x - p1.x, y : p0.y - p1.y};
};
com_dango_$itimi_geom_PointUtil.mul = function(p0,s) {
	return { x : p0.x * s, y : p0.y * s};
};
com_dango_$itimi_geom_PointUtil.div = function(p0,s) {
	return { x : p0.x / s, y : p0.y / s};
};
com_dango_$itimi_geom_PointUtil.abs = function(p0) {
	return { x : Math.abs(p0.x), y : Math.abs(p0.y)};
};
com_dango_$itimi_geom_PointUtil.opposite = function(p0) {
	return { x : -p0.x, y : -p0.y};
};
com_dango_$itimi_geom_PointUtil.perpendicular = function(p0) {
	return { x : -p0.y, y : p0.x};
};
com_dango_$itimi_geom_PointUtil.normalize = function(p0,t) {
	if(t == null) t = 1.0;
	var m = t / Math.sqrt(p0.x * p0.x + p0.y * p0.y);
	return { x : p0.x * m, y : p0.y * m};
};
com_dango_$itimi_geom_PointUtil.interpolate = function(p0,p1,f) {
	return { x : (p1.x - p0.x) * f + p0.x, y : (p1.y - p0.y) * f + p0.y};
};
com_dango_$itimi_geom_PointUtil.pivot = function(p0,p1,a) {
	var x = p0.x - p1.y;
	var y = p0.y - p1.y;
	var l = Math.sqrt(x * x + y * y);
	var an = Math.atan2(y,x) + a;
	return { x : p1.x + l * Math.cos(a), y : p1.y + l * Math.sin(a)};
};
com_dango_$itimi_geom_PointUtil.project = function(p0,p1) {
	var il = 1 / (Math.sqrt(p0.x * p0.x + p0.y * p0.y) * Math.sqrt(p1.x * p1.x + p1.y * p1.y));
	var m = (p0.x * p1.x + p0.y * p1.y) * il;
	return { x : p1.x * m, y : p1.y * m};
};
var com_dango_$itimi_geom_RectangleUtil = function() { };
$hxClasses["com.dango_itimi.geom.RectangleUtil"] = com_dango_$itimi_geom_RectangleUtil;
com_dango_$itimi_geom_RectangleUtil.__name__ = ["com","dango_itimi","geom","RectangleUtil"];
com_dango_$itimi_geom_RectangleUtil.getRight = function(rectangle) {
	return rectangle.x + rectangle.width;
};
com_dango_$itimi_geom_RectangleUtil.getBottom = function(rectangle) {
	return rectangle.y + rectangle.height;
};
com_dango_$itimi_geom_RectangleUtil.create = function(x,y,width,height) {
	return { x : x, y : y, width : width, height : height};
};
com_dango_$itimi_geom_RectangleUtil.clone = function(rectangle) {
	return com_dango_$itimi_geom_RectangleUtil.create(rectangle.x,rectangle.y,rectangle.width,rectangle.height);
};
com_dango_$itimi_geom_RectangleUtil.setPosition = function(rectangle,x,y) {
	rectangle.x = x;
	rectangle.y = y;
};
com_dango_$itimi_geom_RectangleUtil.setPoint = function(rectangle,point) {
	com_dango_$itimi_geom_RectangleUtil.setPosition(rectangle,point.x,point.y);
};
com_dango_$itimi_geom_RectangleUtil.addPosition = function(rectangle,addedX,addedY) {
	rectangle.x += addedX;
	rectangle.y += addedY;
};
com_dango_$itimi_geom_RectangleUtil.addPoint = function(rectangle,point) {
	com_dango_$itimi_geom_RectangleUtil.addPosition(rectangle,point.x,point.y);
};
com_dango_$itimi_geom_RectangleUtil.hitTestPosition = function(rectangle,x,y) {
	return rectangle.x <= x && rectangle.y <= y && com_dango_$itimi_geom_RectangleUtil.getRight(rectangle) >= x && com_dango_$itimi_geom_RectangleUtil.getBottom(rectangle) >= y;
};
com_dango_$itimi_geom_RectangleUtil.hitTestPoint = function(rectangle,point) {
	return com_dango_$itimi_geom_RectangleUtil.hitTestPosition(rectangle,point.x,point.y);
};
com_dango_$itimi_geom_RectangleUtil.hitTestObject = function(rectangle1,rectangle2) {
	if(rectangle1.x > com_dango_$itimi_geom_RectangleUtil.getRight(rectangle2)) return false;
	if(com_dango_$itimi_geom_RectangleUtil.getRight(rectangle1) < rectangle2.x) return false;
	if(rectangle1.y > com_dango_$itimi_geom_RectangleUtil.getBottom(rectangle2)) return false;
	if(com_dango_$itimi_geom_RectangleUtil.getBottom(rectangle1) < rectangle2.y) return false;
	return true;
};
var com_dango_$itimi_scenario_core_Event = function(id) {
	this.id = id;
	this.enabled = false;
	this.completed = false;
	this.requiredCompletionEvents = [];
	this.enabledEventsAfterCompletion = [];
	this.disenabledEventsAfterCompletion = [];
};
$hxClasses["com.dango_itimi.scenario.core.Event"] = com_dango_$itimi_scenario_core_Event;
com_dango_$itimi_scenario_core_Event.__name__ = ["com","dango_itimi","scenario","core","Event"];
com_dango_$itimi_scenario_core_Event.prototype = {
	enable: function() {
		this.enabled = true;
		this.completed = false;
	}
	,disenable: function() {
		this.enabled = false;
	}
	,isCompletable: function() {
		var _g = 0;
		var _g1 = this.requiredCompletionEvents;
		while(_g < _g1.length) {
			var event = _g1[_g];
			++_g;
			if(!event.completed) return false;
		}
		return true;
	}
	,complete: function() {
		this.enabled = false;
		this.completed = true;
		var _g = 0;
		var _g1 = this.enabledEventsAfterCompletion;
		while(_g < _g1.length) {
			var event = _g1[_g];
			++_g;
			event.enable();
		}
		var _g2 = 0;
		var _g11 = this.disenabledEventsAfterCompletion;
		while(_g2 < _g11.length) {
			var event1 = _g11[_g2];
			++_g2;
			event1.disenable();
		}
	}
	,isRequiredCompletionEvent: function(checked) {
		var _g = 0;
		var _g1 = this.requiredCompletionEvents;
		while(_g < _g1.length) {
			var event = _g1[_g];
			++_g;
			if(checked == event) return true;
		}
		return false;
	}
	,__class__: com_dango_$itimi_scenario_core_Event
};
var com_dango_$itimi_scenario_core_Scene = function() {
	this.eventSet = [];
	this.createEventAutomatically();
};
$hxClasses["com.dango_itimi.scenario.core.Scene"] = com_dango_$itimi_scenario_core_Scene;
com_dango_$itimi_scenario_core_Scene.__name__ = ["com","dango_itimi","scenario","core","Scene"];
com_dango_$itimi_scenario_core_Scene.prototype = {
	createEventAutomatically: function() {
		if(this.autoCreationEventInstanceClass == null) this.autoCreationEventInstanceClass = com_dango_$itimi_scenario_core_Event;
		var metaFieldSet = com_dango_$itimi_utils_MetaUtil.getMetaFieldsWithInstance(this,"event");
		var _g = 0;
		while(_g < metaFieldSet.length) {
			var metaField = metaFieldSet[_g];
			++_g;
			var eventId = Type.getClassName(js_Boot.getClass(this)) + "." + metaField.name;
			var event = Type.createInstance(this.autoCreationEventInstanceClass,[eventId]);
			this.eventSet.push(event);
			Reflect.setProperty(this,metaField.name,event);
		}
	}
	,__class__: com_dango_$itimi_scenario_core_Scene
};
var com_dango_$itimi_scenario_core_Sequence = function() {
	this.sceneSet = [];
	this.setExtendedSceneClassPackagesString();
	var metaFieldSet = com_dango_$itimi_utils_MetaUtil.getMetaFieldsWithInstance(this,"scene");
	var _g = 0;
	while(_g < metaFieldSet.length) {
		var metaField = metaFieldSet[_g];
		++_g;
		var metaFieldName = metaField.name;
		var sceneClass = this.getSceneClass(metaFieldName);
		var scene = Type.createInstance(sceneClass,[]);
		this.sceneSet.push(scene);
		Reflect.setProperty(this,metaFieldName,scene);
	}
};
$hxClasses["com.dango_itimi.scenario.core.Sequence"] = com_dango_$itimi_scenario_core_Sequence;
com_dango_$itimi_scenario_core_Sequence.__name__ = ["com","dango_itimi","scenario","core","Sequence"];
com_dango_$itimi_scenario_core_Sequence.prototype = {
	setExtendedSceneClassPackagesString: function() {
		if(this.extendedSceneClassPackagesString != null) return;
		var baseClass = js_Boot.getClass(this);
		var packages = Type.getClassName(baseClass).split(".");
		packages.pop();
		this.extendedSceneClassPackagesString = packages.join(".");
	}
	,getSceneClass: function(metaFieldName) {
		var smallFirstCharacter = metaFieldName.charAt(0);
		var largeFirstCharacter = smallFirstCharacter.toUpperCase();
		var noteClassName = largeFirstCharacter + metaFieldName.substring(1,metaFieldName.length);
		var noteClassPath = this.extendedSceneClassPackagesString + "." + noteClassName;
		return Type.resolveClass(noteClassPath);
	}
	,__class__: com_dango_$itimi_scenario_core_Sequence
};
var com_dango_$itimi_scenario_core_SequenceUtil = function() { };
$hxClasses["com.dango_itimi.scenario.core.SequenceUtil"] = com_dango_$itimi_scenario_core_SequenceUtil;
com_dango_$itimi_scenario_core_SequenceUtil.__name__ = ["com","dango_itimi","scenario","core","SequenceUtil"];
com_dango_$itimi_scenario_core_SequenceUtil.checkOnlyEnabledEventSet = function(sequence,onlyEnabledEventSet) {
	var enabledEventSet = com_dango_$itimi_scenario_core_SequenceUtil.getEnabledEventSet(sequence);
	if(onlyEnabledEventSet.length != enabledEventSet.length) return false;
	var _g = 0;
	while(_g < onlyEnabledEventSet.length) {
		var checkedEvent = onlyEnabledEventSet[_g];
		++_g;
		var equals = false;
		var _g1 = 0;
		while(_g1 < enabledEventSet.length) {
			var enabledEvent = enabledEventSet[_g1];
			++_g1;
			if(checkedEvent != enabledEvent) continue;
			equals = true;
			break;
		}
		if(!equals) return false;
	}
	return true;
};
com_dango_$itimi_scenario_core_SequenceUtil.getEnabledEventSet = function(sequence) {
	var enabledEventSet = [];
	var _g = 0;
	var _g1 = sequence.sceneSet;
	while(_g < _g1.length) {
		var scene = _g1[_g];
		++_g;
		var _g2 = 0;
		var _g3 = scene.eventSet;
		while(_g2 < _g3.length) {
			var event = _g3[_g2];
			++_g2;
			if(event.enabled) enabledEventSet.push(event);
		}
	}
	return enabledEventSet;
};
com_dango_$itimi_scenario_core_SequenceUtil.getEventMap = function(sequence) {
	var eventMap = new haxe_ds_StringMap();
	var _g = 0;
	var _g1 = sequence.sceneSet;
	while(_g < _g1.length) {
		var scene = _g1[_g];
		++_g;
		var _g2 = 0;
		var _g3 = scene.eventSet;
		while(_g2 < _g3.length) {
			var event = _g3[_g2];
			++_g2;
			{
				eventMap.set(event.id,event);
				event;
			}
		}
	}
	return eventMap;
};
var com_dango_$itimi_scenario_framework_Appraiser = function() { };
$hxClasses["com.dango_itimi.scenario.framework.Appraiser"] = com_dango_$itimi_scenario_framework_Appraiser;
com_dango_$itimi_scenario_framework_Appraiser.__name__ = ["com","dango_itimi","scenario","framework","Appraiser"];
com_dango_$itimi_scenario_framework_Appraiser.checkUnsetDirection = function(sequence,directionMap) {
	var unsetEventIds = [];
	var _g = 0;
	var _g1 = sequence.sceneSet;
	while(_g < _g1.length) {
		var scene = _g1[_g];
		++_g;
		var _g2 = 0;
		var _g3 = scene.eventSet;
		while(_g2 < _g3.length) {
			var event = _g3[_g2];
			++_g2;
			var direction = directionMap.map.h[event.__id__];
			if(direction == null) unsetEventIds.push(event.id);
		}
	}
	if(unsetEventIds.length == 0) return;
	throw new js__$Boot_HaxeError("Unset Direction:\n" + unsetEventIds.join("\n"));
};
com_dango_$itimi_scenario_framework_Appraiser.checkUnsetEventIdInAreaMap = function(sequence,areaManager) {
	var unsetEventIdsInAreaMap = [];
	var _g = 0;
	var _g1 = sequence.sceneSet;
	while(_g < _g1.length) {
		var scene = _g1[_g];
		++_g;
		var unsetEvents = [];
		var _g2 = 0;
		var _g3 = scene.eventSet;
		while(_g2 < _g3.length) {
			var event = _g3[_g2];
			++_g2;
			if(!areaManager.isIncludedInAreaMap(event)) unsetEvents.push(event);
		}
		if(unsetEvents.length == 0) continue;
		var _g21 = 0;
		while(_g21 < unsetEvents.length) {
			var event1 = unsetEvents[_g21];
			++_g21;
			unsetEventIdsInAreaMap.push(event1.id);
		}
	}
	if(unsetEventIdsInAreaMap.length == 0) return;
	throw new js__$Boot_HaxeError("Unset Event ID List In AreaMap:\n" + unsetEventIdsInAreaMap.join("\n"));
};
com_dango_$itimi_scenario_framework_Appraiser.checkSkipDirectionInAllAction = function(sequence,directionMap) {
	var errorCutEventMessage = [];
	var _g = 0;
	var _g1 = sequence.sceneSet;
	while(_g < _g1.length) {
		var scene = _g1[_g];
		++_g;
		var _g2 = 0;
		var _g3 = scene.eventSet;
		while(_g2 < _g3.length) {
			var event = _g3[_g2];
			++_g2;
			var direction = directionMap.map.h[event.__id__];
			var filmErrorMessageSet = [];
			var errorCutIndexSet;
			errorCutIndexSet = com_dango_$itimi_scenario_framework_Appraiser.getErrorCutIndexSet(direction.firedFilm);
			com_dango_$itimi_scenario_framework_Appraiser.setErrorCutMessage(filmErrorMessageSet,"firedFilm",errorCutIndexSet);
			errorCutIndexSet = com_dango_$itimi_scenario_framework_Appraiser.getErrorCutIndexSet(direction.checkedFilm);
			com_dango_$itimi_scenario_framework_Appraiser.setErrorCutMessage(filmErrorMessageSet,"checkedFilm",errorCutIndexSet);
			errorCutIndexSet = com_dango_$itimi_scenario_framework_Appraiser.getErrorCutIndexSet(direction.equipedIncorrectItemFilm);
			com_dango_$itimi_scenario_framework_Appraiser.setErrorCutMessage(filmErrorMessageSet,"equipedIncorrectItemFilm",errorCutIndexSet);
			if(filmErrorMessageSet.length == 0) continue;
			var message = event.id + ": Skip play frame count reached the limit.\n" + filmErrorMessageSet.join("\n");
			errorCutEventMessage.push(message);
		}
	}
	if(errorCutEventMessage.length > 0) throw new js__$Boot_HaxeError(errorCutEventMessage.join("\n"));
};
com_dango_$itimi_scenario_framework_Appraiser.getErrorCutIndexSet = function(film) {
	if(film == null) return null;
	var errorCutIndexSet = [];
	var _g1 = 0;
	var _g = film.cutSet.length;
	while(_g1 < _g) {
		var i = _g1++;
		var cut = film.cutSet[i];
		if(cut.action == null) continue;
		cut.action.initialize();
		if(!cut.action.playDirect()) errorCutIndexSet.push(i);
	}
	return errorCutIndexSet;
};
com_dango_$itimi_scenario_framework_Appraiser.setErrorCutMessage = function(errorMessageSet,filmName,errorCutIndexSet) {
	if(errorCutIndexSet == null || errorCutIndexSet.length == 0) return;
	var message = filmName + ": " + errorCutIndexSet.join(",");
	errorMessageSet.push(message);
};
var com_dango_$itimi_scenario_framework_Director = function(inventory,directionMap,areaManager,recorder) {
	this.inventory = inventory;
	this.directionMap = directionMap;
	this.areaManager = areaManager;
	this.recorder = recorder;
};
$hxClasses["com.dango_itimi.scenario.framework.Director"] = com_dango_$itimi_scenario_framework_Director;
com_dango_$itimi_scenario_framework_Director.__name__ = ["com","dango_itimi","scenario","framework","Director"];
com_dango_$itimi_scenario_framework_Director.prototype = {
	progress: function(scene,checkPosition) {
		{
			var _g = com_dango_$itimi_scenario_framework_Scenario.read(this.areaManager,scene,checkPosition);
			switch(_g[1]) {
			case 0:case 1:
				return null;
			case 2:
				var event = _g[2];
				return this.orderNonattainment(event);
			case 3:
				var complatableEvent = _g[2];
				return this.orderAdvance(complatableEvent);
			}
		}
	}
	,orderNonattainment: function(event) {
		var direction = this.directionMap.map.h[event.__id__];
		if(direction.equipedIncorrectItemFilm != null && this.inventory.isSelected(direction.equipedIncorrectItemFilm.item)) return direction.equipedIncorrectItemFilm; else if(direction.checkedFilm != null) return direction.checkedFilm;
		return null;
	}
	,orderAdvance: function(event) {
		event.complete();
		if(this.recorder != null) this.recorder.add(event.id);
		var direction = this.directionMap.map.h[event.__id__];
		return direction.firedFilm;
	}
	,__class__: com_dango_$itimi_scenario_framework_Director
};
var com_dango_$itimi_scenario_framework_ProjectorEvent = $hxClasses["com.dango_itimi.scenario.framework.ProjectorEvent"] = { __ename__ : ["com","dango_itimi","scenario","framework","ProjectorEvent"], __constructs__ : ["NONE","CUT_START","FINISH"] };
com_dango_$itimi_scenario_framework_ProjectorEvent.NONE = ["NONE",0];
com_dango_$itimi_scenario_framework_ProjectorEvent.NONE.toString = $estr;
com_dango_$itimi_scenario_framework_ProjectorEvent.NONE.__enum__ = com_dango_$itimi_scenario_framework_ProjectorEvent;
com_dango_$itimi_scenario_framework_ProjectorEvent.CUT_START = function(cutStart) { var $x = ["CUT_START",1,cutStart]; $x.__enum__ = com_dango_$itimi_scenario_framework_ProjectorEvent; $x.toString = $estr; return $x; };
com_dango_$itimi_scenario_framework_ProjectorEvent.FINISH = ["FINISH",2];
com_dango_$itimi_scenario_framework_ProjectorEvent.FINISH.toString = $estr;
com_dango_$itimi_scenario_framework_ProjectorEvent.FINISH.__enum__ = com_dango_$itimi_scenario_framework_ProjectorEvent;
var com_dango_$itimi_scenario_framework_CutStart = $hxClasses["com.dango_itimi.scenario.framework.CutStart"] = { __ename__ : ["com","dango_itimi","scenario","framework","CutStart"], __constructs__ : ["NONE","ITEM_CHANGE","EQUIPED_INCORRECT_ITEM"] };
com_dango_$itimi_scenario_framework_CutStart.NONE = ["NONE",0];
com_dango_$itimi_scenario_framework_CutStart.NONE.toString = $estr;
com_dango_$itimi_scenario_framework_CutStart.NONE.__enum__ = com_dango_$itimi_scenario_framework_CutStart;
com_dango_$itimi_scenario_framework_CutStart.ITEM_CHANGE = function(itemChange) { var $x = ["ITEM_CHANGE",1,itemChange]; $x.__enum__ = com_dango_$itimi_scenario_framework_CutStart; $x.toString = $estr; return $x; };
com_dango_$itimi_scenario_framework_CutStart.EQUIPED_INCORRECT_ITEM = function(item) { var $x = ["EQUIPED_INCORRECT_ITEM",2,item]; $x.__enum__ = com_dango_$itimi_scenario_framework_CutStart; $x.toString = $estr; return $x; };
var com_dango_$itimi_scenario_framework_Projector = function(subtitle) {
	this.subtitle = subtitle;
};
$hxClasses["com.dango_itimi.scenario.framework.Projector"] = com_dango_$itimi_scenario_framework_Projector;
com_dango_$itimi_scenario_framework_Projector.__name__ = ["com","dango_itimi","scenario","framework","Projector"];
com_dango_$itimi_scenario_framework_Projector.prototype = {
	getEvent: function() {
		var n = this.event;
		this.event = com_dango_$itimi_scenario_framework_ProjectorEvent.NONE;
		return n;
	}
	,run: function() {
		this.mainFunction();
	}
	,initialize: function(film) {
		this.film = film;
		this.event = com_dango_$itimi_scenario_framework_ProjectorEvent.NONE;
		this.cutIndex = 0;
		this.setDisplayCut();
	}
	,setDisplayCut: function() {
		this.displayCut = this.film.cutSet[this.cutIndex];
		var cutStartEvent;
		if(js_Boot.__instanceof(this.displayCut,com_dango_$itimi_scenario_framework_direction_ItemChangeCut)) cutStartEvent = com_dango_$itimi_scenario_framework_CutStart.ITEM_CHANGE((js_Boot.__cast(this.displayCut , com_dango_$itimi_scenario_framework_direction_ItemChangeCut)).itemChange); else if(js_Boot.__instanceof(this.film,com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm) && (js_Boot.__cast(this.film , com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm)).directionCutIndex == this.cutIndex) cutStartEvent = com_dango_$itimi_scenario_framework_CutStart.EQUIPED_INCORRECT_ITEM((js_Boot.__cast(this.film , com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm)).item); else cutStartEvent = com_dango_$itimi_scenario_framework_CutStart.NONE;
		this.event = com_dango_$itimi_scenario_framework_ProjectorEvent.CUT_START(cutStartEvent);
		if(this.displayCut.action != null && this.displayCut.text != null) {
			var _g = this.displayCut.textDisplayTymingInAction;
			switch(_g[1]) {
			case 1:
				this.initializeToPlayText($bind(this,this.initializeToPlayAction));
				break;
			case 0:
				this.initializeToPlayActionAndText();
				break;
			case 2:
				this.initializeToPlayAction();
				break;
			}
		} else if(this.displayCut.action == null) this.initializeToPlayText($bind(this,this.waitClapperboard)); else this.initializeToPlayAction();
	}
	,isPlaying: function() {
		return Reflect.compareMethods(this.mainFunction,$bind(this,this.playText)) || Reflect.compareMethods(this.mainFunction,$bind(this,this.playAction)) || Reflect.compareMethods(this.mainFunction,$bind(this,this.playActionAndText));
	}
	,initializeToPlayText: function(nextFunctionAfterPlayText) {
		this.nextFunctionAfterPlayText = nextFunctionAfterPlayText;
		this.subtitle.initialize(this.displayCut.text);
		this.displayCut.skipOperation.initialize();
		this.mainFunction = $bind(this,this.playText);
	}
	,playText: function() {
		this.subtitle.run();
		this.displayCut.skipOperation.run();
		if(this.displayCut.skipOperation.isExecuted()) this.subtitle.orderSkip();
		if(this.subtitle.isFinished()) this.nextFunctionAfterPlayText();
	}
	,initializeToPlayAction: function() {
		this.displayCut.action.initialize();
		this.displayCut.skipOperation.initialize();
		this.mainFunction = $bind(this,this.playAction);
	}
	,playAction: function() {
		this.displayCut.action.run();
		this.displayCut.skipOperation.run();
		if(this.displayCut.skipOperation.isExecuted()) this.displayCut.action.playDirect();
		if(this.displayCut.action.isFinished()) {
			if(this.displayCut.text == null) this.initializeToWaitClapperboard(); else {
				var _g = this.displayCut.textDisplayTymingInAction;
				switch(_g[1]) {
				case 2:
					this.initializeToPlayText($bind(this,this.initializeToWaitClapperboard));
					break;
				default:
					this.initializeToWaitClapperboard();
				}
			}
		}
	}
	,initializeToPlayActionAndText: function() {
		this.displayCut.action.initialize();
		this.subtitle.initialize(this.displayCut.text);
		this.displayCut.skipOperation.initialize();
		this.mainFunction = $bind(this,this.playActionAndText);
	}
	,playActionAndText: function() {
		this.displayCut.action.run();
		this.subtitle.run();
		this.displayCut.skipOperation.run();
		if(this.displayCut.skipOperation.isExecuted()) {
			this.subtitle.orderSkip();
			this.displayCut.action.playDirect();
		}
		if(this.displayCut.action.isFinished() && this.subtitle.isFinished()) this.initializeToWaitClapperboard();
	}
	,initializeToWaitClapperboard: function() {
		this.displayCut.clapperboard.initialize();
		this.mainFunction = $bind(this,this.waitClapperboard);
	}
	,waitClapperboard: function() {
		this.displayCut.clapperboard.run();
		if(this.displayCut.clapperboard.isExecuted()) this.destroyToPlay();
	}
	,isWaitingClapperboard: function() {
		return Reflect.compareMethods(this.mainFunction,$bind(this,this.waitClapperboard));
	}
	,destroyToPlay: function() {
		if(++this.cutIndex < this.film.cutSet.length) this.setDisplayCut(); else {
			this.event = com_dango_$itimi_scenario_framework_ProjectorEvent.FINISH;
			this.mainFunction = $bind(this,this.finish);
		}
	}
	,finish: function() {
	}
	,__class__: com_dango_$itimi_scenario_framework_Projector
};
var com_dango_$itimi_scenario_framework_Progress = $hxClasses["com.dango_itimi.scenario.framework.Progress"] = { __ename__ : ["com","dango_itimi","scenario","framework","Progress"], __constructs__ : ["NO_HITAREA","NO_ENABLED_EVENT","UNCOMPLETABLE","ADVANCE"] };
com_dango_$itimi_scenario_framework_Progress.NO_HITAREA = ["NO_HITAREA",0];
com_dango_$itimi_scenario_framework_Progress.NO_HITAREA.toString = $estr;
com_dango_$itimi_scenario_framework_Progress.NO_HITAREA.__enum__ = com_dango_$itimi_scenario_framework_Progress;
com_dango_$itimi_scenario_framework_Progress.NO_ENABLED_EVENT = ["NO_ENABLED_EVENT",1];
com_dango_$itimi_scenario_framework_Progress.NO_ENABLED_EVENT.toString = $estr;
com_dango_$itimi_scenario_framework_Progress.NO_ENABLED_EVENT.__enum__ = com_dango_$itimi_scenario_framework_Progress;
com_dango_$itimi_scenario_framework_Progress.UNCOMPLETABLE = function(event) { var $x = ["UNCOMPLETABLE",2,event]; $x.__enum__ = com_dango_$itimi_scenario_framework_Progress; $x.toString = $estr; return $x; };
com_dango_$itimi_scenario_framework_Progress.ADVANCE = function(complatableEvent) { var $x = ["ADVANCE",3,complatableEvent]; $x.__enum__ = com_dango_$itimi_scenario_framework_Progress; $x.toString = $estr; return $x; };
var com_dango_$itimi_scenario_framework_Scenario = function() { };
$hxClasses["com.dango_itimi.scenario.framework.Scenario"] = com_dango_$itimi_scenario_framework_Scenario;
com_dango_$itimi_scenario_framework_Scenario.__name__ = ["com","dango_itimi","scenario","framework","Scenario"];
com_dango_$itimi_scenario_framework_Scenario.hasProgressEvent = function(areaManager,scene,checkPosition) {
	var _g = com_dango_$itimi_scenario_framework_Scenario.read(areaManager,scene,checkPosition);
	switch(_g[1]) {
	case 3:
		return true;
	default:
		return false;
	}
};
com_dango_$itimi_scenario_framework_Scenario.read = function(areaManager,scene,checkPosition) {
	var areaMap = areaManager.getAreaMap(scene);
	var hitAreaSet = areaMap.getHitAreaSet(checkPosition);
	if(hitAreaSet.length == 0) return com_dango_$itimi_scenario_framework_Progress.NO_HITAREA;
	var enabledEventSet = [];
	var _g = 0;
	while(_g < hitAreaSet.length) {
		var hitArea = hitAreaSet[_g];
		++_g;
		var eventSet = areaMap.getEnabledEventSet(hitArea);
		enabledEventSet = enabledEventSet.concat(eventSet);
		if(enabledEventSet.length > 1) throw new js__$Boot_HaxeError("enabled event setting error");
	}
	if(enabledEventSet.length == 0) return com_dango_$itimi_scenario_framework_Progress.NO_ENABLED_EVENT;
	var event = enabledEventSet[0];
	if(!event.isCompletable()) return com_dango_$itimi_scenario_framework_Progress.UNCOMPLETABLE(event); else return com_dango_$itimi_scenario_framework_Progress.ADVANCE(event);
};
var com_dango_$itimi_scenario_framework_area_AreaManager = function() {
	this.map = new haxe_ds_ObjectMap();
	this.eventMap = new haxe_ds_ObjectMap();
};
$hxClasses["com.dango_itimi.scenario.framework.area.AreaManager"] = com_dango_$itimi_scenario_framework_area_AreaManager;
com_dango_$itimi_scenario_framework_area_AreaManager.__name__ = ["com","dango_itimi","scenario","framework","area","AreaManager"];
com_dango_$itimi_scenario_framework_area_AreaManager.prototype = {
	register: function(sequence) {
		var _g = 0;
		var _g1 = sequence.sceneSet;
		while(_g < _g1.length) {
			var scene = _g1[_g];
			++_g;
			var v = new com_dango_$itimi_scenario_framework_area_AreaMap();
			this.map.set(scene,v);
			v;
			var _g2 = 0;
			var _g3 = scene.eventSet;
			while(_g2 < _g3.length) {
				var event = _g3[_g2];
				++_g2;
				{
					this.eventMap.set(event,scene);
					scene;
				}
			}
		}
	}
	,set: function(hitArea,event) {
		var scene = this.eventMap.h[event.__id__];
		var areaMap = this.getAreaMap(scene);
		areaMap.set(hitArea,event);
	}
	,getAreaMap: function(scene) {
		return this.map.h[scene.__id__];
	}
	,isIncludedInAreaMap: function(checked) {
		var scene = this.eventMap.h[checked.__id__];
		var areaMap = this.getAreaMap(scene);
		return areaMap.isIncludedInAreaMap(checked);
	}
	,__class__: com_dango_$itimi_scenario_framework_area_AreaManager
};
var com_dango_$itimi_scenario_framework_area_AreaMap = function() {
	this.map = new haxe_ds_ObjectMap();
};
$hxClasses["com.dango_itimi.scenario.framework.area.AreaMap"] = com_dango_$itimi_scenario_framework_area_AreaMap;
com_dango_$itimi_scenario_framework_area_AreaMap.__name__ = ["com","dango_itimi","scenario","framework","area","AreaMap"];
com_dango_$itimi_scenario_framework_area_AreaMap.prototype = {
	set: function(hitArea,event) {
		if(this.isIncludedInAreaMap(event)) throw new js__$Boot_HaxeError(event.id + "is included in area map already");
		if(this.map.h[hitArea.__id__] == null) {
			var v = [];
			this.map.set(hitArea,v);
			v;
		}
		this.map.h[hitArea.__id__].push(event);
	}
	,isIncludedInAreaMap: function(checked) {
		var $it0 = this.map.keys();
		while( $it0.hasNext() ) {
			var hitArea = $it0.next();
			var _g = 0;
			var _g1 = this.map.h[hitArea.__id__];
			while(_g < _g1.length) {
				var event = _g1[_g];
				++_g;
				if(checked == event) return true;
			}
		}
		return false;
	}
	,getHitAreaSet: function(checkPosition) {
		var hitAreaSet = [];
		var $it0 = this.map.keys();
		while( $it0.hasNext() ) {
			var key = $it0.next();
			var hitArea = key;
			if(com_dango_$itimi_geom_RectangleUtil.hitTestPoint(hitArea,checkPosition)) hitAreaSet.push(hitArea);
		}
		return hitAreaSet;
	}
	,getEnabledEventSet: function(hitArea) {
		var enabledEventSet = [];
		var eventSet = this.map.h[hitArea.__id__];
		var _g = 0;
		while(_g < eventSet.length) {
			var event = eventSet[_g];
			++_g;
			if(event.enabled) enabledEventSet.push(event);
		}
		return enabledEventSet;
	}
	,__class__: com_dango_$itimi_scenario_framework_area_AreaMap
};
var com_dango_$itimi_scenario_framework_direction_Cut = function(clapperboard,skipOperation,action,text,textDisplayTymingInAction) {
	this.clapperboard = clapperboard;
	if(skipOperation == null) this.skipOperation = new com_dango_$itimi_scenario_framework_direction_interaction_Interaction(); else this.skipOperation = skipOperation;
	this.action = action;
	this.text = text;
	this.textDisplayTymingInAction = textDisplayTymingInAction;
	if(action == null && text == null) throw new js__$Boot_HaxeError("set action or text");
	if(text != null && textDisplayTymingInAction == null) this.textDisplayTymingInAction = com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.SAME;
};
$hxClasses["com.dango_itimi.scenario.framework.direction.Cut"] = com_dango_$itimi_scenario_framework_direction_Cut;
com_dango_$itimi_scenario_framework_direction_Cut.__name__ = ["com","dango_itimi","scenario","framework","direction","Cut"];
com_dango_$itimi_scenario_framework_direction_Cut.prototype = {
	__class__: com_dango_$itimi_scenario_framework_direction_Cut
};
var com_dango_$itimi_scenario_framework_direction_ItemChangeCut = function(itemChange,clapperboard,skipOperation,action,text,textDisplayTymingInAction) {
	this.itemChange = itemChange;
	com_dango_$itimi_scenario_framework_direction_Cut.call(this,clapperboard,skipOperation,action,text,textDisplayTymingInAction);
};
$hxClasses["com.dango_itimi.scenario.framework.direction.ItemChangeCut"] = com_dango_$itimi_scenario_framework_direction_ItemChangeCut;
com_dango_$itimi_scenario_framework_direction_ItemChangeCut.__name__ = ["com","dango_itimi","scenario","framework","direction","ItemChangeCut"];
com_dango_$itimi_scenario_framework_direction_ItemChangeCut.__super__ = com_dango_$itimi_scenario_framework_direction_Cut;
com_dango_$itimi_scenario_framework_direction_ItemChangeCut.prototype = $extend(com_dango_$itimi_scenario_framework_direction_Cut.prototype,{
	__class__: com_dango_$itimi_scenario_framework_direction_ItemChangeCut
});
var com_dango_$itimi_scenario_framework_direction_Direction = function(firedFilm,checkedFilm,equipedIncorrectItemFilm) {
	this.firedFilm = firedFilm;
	this.checkedFilm = checkedFilm;
	this.equipedIncorrectItemFilm = equipedIncorrectItemFilm;
};
$hxClasses["com.dango_itimi.scenario.framework.direction.Direction"] = com_dango_$itimi_scenario_framework_direction_Direction;
com_dango_$itimi_scenario_framework_direction_Direction.__name__ = ["com","dango_itimi","scenario","framework","direction","Direction"];
com_dango_$itimi_scenario_framework_direction_Direction.prototype = {
	__class__: com_dango_$itimi_scenario_framework_direction_Direction
};
var com_dango_$itimi_scenario_framework_direction_DirectionMap = function() {
	this.map = new haxe_ds_ObjectMap();
};
$hxClasses["com.dango_itimi.scenario.framework.direction.DirectionMap"] = com_dango_$itimi_scenario_framework_direction_DirectionMap;
com_dango_$itimi_scenario_framework_direction_DirectionMap.__name__ = ["com","dango_itimi","scenario","framework","direction","DirectionMap"];
com_dango_$itimi_scenario_framework_direction_DirectionMap.prototype = {
	set: function(event,firedFilm,checkedFilm,equipedIncorrectItemFilm) {
		if(this.map.h[event.__id__] != null) throw new js__$Boot_HaxeError(event.id + " is included in direction map already");
		if(equipedIncorrectItemFilm != null && firedFilm == null) throw new js__$Boot_HaxeError("Set firedFilm: " + event.id);
		if(equipedIncorrectItemFilm != null && this.isUnsetRequiredItems(event,equipedIncorrectItemFilm)) throw new js__$Boot_HaxeError("Set Item to requiredCompletionEvents: " + event.id);
		var v = new com_dango_$itimi_scenario_framework_direction_Direction(firedFilm,checkedFilm,equipedIncorrectItemFilm);
		this.map.set(event,v);
		v;
	}
	,isUnsetRequiredItems: function(event,equipedIncorrectItemFilm) {
		if(event.requiredCompletionEvents == null) return true;
		var _g = 0;
		var _g1 = event.requiredCompletionEvents;
		while(_g < _g1.length) {
			var requiredCompletionEvent = _g1[_g];
			++_g;
			if(js_Boot.__instanceof(requiredCompletionEvent,com_dango_$itimi_scenario_framework_item_Item)) return false;
		}
		return true;
	}
	,get: function(event) {
		return this.map.h[event.__id__];
	}
	,__class__: com_dango_$itimi_scenario_framework_direction_DirectionMap
};
var com_dango_$itimi_scenario_framework_direction_Film = function(cut) {
	this.cutSet = [];
	this.add(cut);
};
$hxClasses["com.dango_itimi.scenario.framework.direction.Film"] = com_dango_$itimi_scenario_framework_direction_Film;
com_dango_$itimi_scenario_framework_direction_Film.__name__ = ["com","dango_itimi","scenario","framework","direction","Film"];
com_dango_$itimi_scenario_framework_direction_Film.prototype = {
	add: function(cut) {
		this.cutSet.push(cut);
	}
	,__class__: com_dango_$itimi_scenario_framework_direction_Film
};
var com_dango_$itimi_scenario_framework_direction_FiredFilm = function(cut) {
	com_dango_$itimi_scenario_framework_direction_Film.call(this,cut);
};
$hxClasses["com.dango_itimi.scenario.framework.direction.FiredFilm"] = com_dango_$itimi_scenario_framework_direction_FiredFilm;
com_dango_$itimi_scenario_framework_direction_FiredFilm.__name__ = ["com","dango_itimi","scenario","framework","direction","FiredFilm"];
com_dango_$itimi_scenario_framework_direction_FiredFilm.__super__ = com_dango_$itimi_scenario_framework_direction_Film;
com_dango_$itimi_scenario_framework_direction_FiredFilm.prototype = $extend(com_dango_$itimi_scenario_framework_direction_Film.prototype,{
	__class__: com_dango_$itimi_scenario_framework_direction_FiredFilm
});
var com_dango_$itimi_scenario_framework_direction_CheckedFilm = function(cut) {
	com_dango_$itimi_scenario_framework_direction_Film.call(this,cut);
};
$hxClasses["com.dango_itimi.scenario.framework.direction.CheckedFilm"] = com_dango_$itimi_scenario_framework_direction_CheckedFilm;
com_dango_$itimi_scenario_framework_direction_CheckedFilm.__name__ = ["com","dango_itimi","scenario","framework","direction","CheckedFilm"];
com_dango_$itimi_scenario_framework_direction_CheckedFilm.__super__ = com_dango_$itimi_scenario_framework_direction_Film;
com_dango_$itimi_scenario_framework_direction_CheckedFilm.prototype = $extend(com_dango_$itimi_scenario_framework_direction_Film.prototype,{
	add: function(cut) {
		if(js_Boot.__instanceof(cut,com_dango_$itimi_scenario_framework_direction_ItemChangeCut)) throw new js__$Boot_HaxeError("You can't set ItemChangeCut to CheckedFilm.");
		com_dango_$itimi_scenario_framework_direction_Film.prototype.add.call(this,cut);
	}
	,__class__: com_dango_$itimi_scenario_framework_direction_CheckedFilm
});
var com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm = function(cut,equipedIncorrectItem,equipedIncorrectItemCutIndex) {
	this.item = equipedIncorrectItem;
	this.directionCutIndex = equipedIncorrectItemCutIndex;
	com_dango_$itimi_scenario_framework_direction_Film.call(this,cut);
};
$hxClasses["com.dango_itimi.scenario.framework.direction.EquipedIncorrectItemFilm"] = com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm;
com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm.__name__ = ["com","dango_itimi","scenario","framework","direction","EquipedIncorrectItemFilm"];
com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm.__super__ = com_dango_$itimi_scenario_framework_direction_Film;
com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm.prototype = $extend(com_dango_$itimi_scenario_framework_direction_Film.prototype,{
	add: function(cut) {
		if(js_Boot.__instanceof(cut,com_dango_$itimi_scenario_framework_direction_ItemChangeCut)) throw new js__$Boot_HaxeError("You can't set ItemChangeCut to EquipedIncorrectItemFilm.");
		com_dango_$itimi_scenario_framework_direction_Film.prototype.add.call(this,cut);
	}
	,__class__: com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm
});
var com_dango_$itimi_scenario_framework_direction_action_ActionInterface = function() { };
$hxClasses["com.dango_itimi.scenario.framework.direction.action.ActionInterface"] = com_dango_$itimi_scenario_framework_direction_action_ActionInterface;
com_dango_$itimi_scenario_framework_direction_action_ActionInterface.__name__ = ["com","dango_itimi","scenario","framework","direction","action","ActionInterface"];
com_dango_$itimi_scenario_framework_direction_action_ActionInterface.prototype = {
	__class__: com_dango_$itimi_scenario_framework_direction_action_ActionInterface
};
var com_dango_$itimi_scenario_framework_direction_action_Action = function(skipPlayRoopMaxCount) {
	if(skipPlayRoopMaxCount != null) this.skipPlayRoopMaxCount = skipPlayRoopMaxCount; else this.skipPlayRoopMaxCount = 1000;
};
$hxClasses["com.dango_itimi.scenario.framework.direction.action.Action"] = com_dango_$itimi_scenario_framework_direction_action_Action;
com_dango_$itimi_scenario_framework_direction_action_Action.__name__ = ["com","dango_itimi","scenario","framework","direction","action","Action"];
com_dango_$itimi_scenario_framework_direction_action_Action.__interfaces__ = [com_dango_$itimi_scenario_framework_direction_action_ActionInterface];
com_dango_$itimi_scenario_framework_direction_action_Action.prototype = {
	run: function() {
		this.mainFunction();
	}
	,initialize: function() {
		this.mainFunction = $bind(this,this.play);
	}
	,play: function() {
		this.mainFunction = $bind(this,this.finish);
	}
	,playDirect: function() {
		var roopFrame = 1000;
		while(roopFrame >= 0) {
			this.run();
			if(this.isFinished()) break;
			roopFrame--;
		}
		return roopFrame >= 0;
	}
	,finish: function() {
	}
	,isFinished: function() {
		return Reflect.compareMethods(this.mainFunction,$bind(this,this.finish));
	}
	,__class__: com_dango_$itimi_scenario_framework_direction_action_Action
};
var com_dango_$itimi_scenario_framework_direction_interaction_InteractionInterface = function() { };
$hxClasses["com.dango_itimi.scenario.framework.direction.interaction.InteractionInterface"] = com_dango_$itimi_scenario_framework_direction_interaction_InteractionInterface;
com_dango_$itimi_scenario_framework_direction_interaction_InteractionInterface.__name__ = ["com","dango_itimi","scenario","framework","direction","interaction","InteractionInterface"];
com_dango_$itimi_scenario_framework_direction_interaction_InteractionInterface.prototype = {
	__class__: com_dango_$itimi_scenario_framework_direction_interaction_InteractionInterface
};
var com_dango_$itimi_scenario_framework_direction_interaction_Interaction = function() {
};
$hxClasses["com.dango_itimi.scenario.framework.direction.interaction.Interaction"] = com_dango_$itimi_scenario_framework_direction_interaction_Interaction;
com_dango_$itimi_scenario_framework_direction_interaction_Interaction.__name__ = ["com","dango_itimi","scenario","framework","direction","interaction","Interaction"];
com_dango_$itimi_scenario_framework_direction_interaction_Interaction.__interfaces__ = [com_dango_$itimi_scenario_framework_direction_interaction_InteractionInterface];
com_dango_$itimi_scenario_framework_direction_interaction_Interaction.prototype = {
	run: function() {
		this.mainFunction();
	}
	,initialize: function() {
		this.mainFunction = $bind(this,this.watch);
	}
	,watch: function() {
	}
	,execute: function() {
	}
	,isExecuted: function() {
		return Reflect.compareMethods(this.mainFunction,$bind(this,this.execute));
	}
	,__class__: com_dango_$itimi_scenario_framework_direction_interaction_Interaction
};
var com_dango_$itimi_scenario_framework_direction_interaction_ClickOperation = function() {
	com_dango_$itimi_scenario_framework_direction_interaction_Interaction.call(this);
};
$hxClasses["com.dango_itimi.scenario.framework.direction.interaction.ClickOperation"] = com_dango_$itimi_scenario_framework_direction_interaction_ClickOperation;
com_dango_$itimi_scenario_framework_direction_interaction_ClickOperation.__name__ = ["com","dango_itimi","scenario","framework","direction","interaction","ClickOperation"];
com_dango_$itimi_scenario_framework_direction_interaction_ClickOperation.__super__ = com_dango_$itimi_scenario_framework_direction_interaction_Interaction;
com_dango_$itimi_scenario_framework_direction_interaction_ClickOperation.prototype = $extend(com_dango_$itimi_scenario_framework_direction_interaction_Interaction.prototype,{
	set_clicked: function(clicked) {
		return this.clicked = clicked;
	}
	,initialize: function() {
		this.set_clicked(false);
		com_dango_$itimi_scenario_framework_direction_interaction_Interaction.prototype.initialize.call(this);
	}
	,watch: function() {
		if(this.clicked) this.mainFunction = $bind(this,this.execute);
	}
	,__class__: com_dango_$itimi_scenario_framework_direction_interaction_ClickOperation
	,__properties__: {set_clicked:"set_clicked"}
});
var com_dango_$itimi_scenario_framework_item_ItemChange = $hxClasses["com.dango_itimi.scenario.framework.item.ItemChange"] = { __ename__ : ["com","dango_itimi","scenario","framework","item","ItemChange"], __constructs__ : ["PICKED_UP","REMOVED","EXCHANGED"] };
com_dango_$itimi_scenario_framework_item_ItemChange.PICKED_UP = function(itemSet) { var $x = ["PICKED_UP",0,itemSet]; $x.__enum__ = com_dango_$itimi_scenario_framework_item_ItemChange; $x.toString = $estr; return $x; };
com_dango_$itimi_scenario_framework_item_ItemChange.REMOVED = function(itemSet) { var $x = ["REMOVED",1,itemSet]; $x.__enum__ = com_dango_$itimi_scenario_framework_item_ItemChange; $x.toString = $estr; return $x; };
com_dango_$itimi_scenario_framework_item_ItemChange.EXCHANGED = function(pickedUp,removed) { var $x = ["EXCHANGED",2,pickedUp,removed]; $x.__enum__ = com_dango_$itimi_scenario_framework_item_ItemChange; $x.toString = $estr; return $x; };
var com_dango_$itimi_scenario_framework_item_Inventory = function() {
	this.set = [];
	this.equipment = null;
};
$hxClasses["com.dango_itimi.scenario.framework.item.Inventory"] = com_dango_$itimi_scenario_framework_item_Inventory;
com_dango_$itimi_scenario_framework_item_Inventory.__name__ = ["com","dango_itimi","scenario","framework","item","Inventory"];
com_dango_$itimi_scenario_framework_item_Inventory.prototype = {
	change: function(itemChange) {
		switch(itemChange[1]) {
		case 0:
			var itemSet = itemChange[2];
			this.pickupSet(itemSet);
			break;
		case 1:
			var itemSet1 = itemChange[2];
			this.removeSet(itemSet1);
			break;
		case 2:
			var removed = itemChange[3];
			var pickedUp = itemChange[2];
			this.exchange(pickedUp,removed);
			break;
		}
	}
	,pickup: function(item) {
		this.set.push(item);
	}
	,pickupSet: function(itemSet) {
		var _g = 0;
		while(_g < itemSet.length) {
			var item = itemSet[_g];
			++_g;
			this.pickup(item);
		}
	}
	,remove: function(item) {
		var i = this.set.length - 1;
		while(i >= 0) {
			if(this.set[i] == item) {
				this.set.splice(i,1);
				break;
			}
			i--;
		}
		if(i <= -1) throw new js__$Boot_HaxeError("You do not have " + item.id);
	}
	,removeSet: function(itemSet) {
		var _g = 0;
		while(_g < itemSet.length) {
			var item = itemSet[_g];
			++_g;
			this.remove(item);
		}
	}
	,exchange: function(pickedUp,removed) {
		this.removeSet(removed);
		this.pickupSet(pickedUp);
	}
	,select: function(item) {
		item.select();
		this.equipment = item;
	}
	,selectFromIndex: function(index) {
		this.select(this.set[index]);
	}
	,unselect: function(item) {
		item.unselect();
		this.equipment = null;
	}
	,isSelected: function(item) {
		return this.equipment != null && item == this.equipment;
	}
	,__class__: com_dango_$itimi_scenario_framework_item_Inventory
};
var com_dango_$itimi_scenario_framework_item_Item = function(id) {
	com_dango_$itimi_scenario_core_Event.call(this,id);
};
$hxClasses["com.dango_itimi.scenario.framework.item.Item"] = com_dango_$itimi_scenario_framework_item_Item;
com_dango_$itimi_scenario_framework_item_Item.__name__ = ["com","dango_itimi","scenario","framework","item","Item"];
com_dango_$itimi_scenario_framework_item_Item.__super__ = com_dango_$itimi_scenario_core_Event;
com_dango_$itimi_scenario_framework_item_Item.prototype = $extend(com_dango_$itimi_scenario_core_Event.prototype,{
	initialize: function(name) {
		this.name = name;
	}
	,select: function() {
		this.completed = true;
	}
	,unselect: function() {
		this.completed = false;
	}
	,__class__: com_dango_$itimi_scenario_framework_item_Item
});
var com_dango_$itimi_scenario_framework_save_Recorder = function(loadedSerializedRecord) {
	if(loadedSerializedRecord == null) this.record = { firedEventIdSet : []}; else this.record = haxe_Unserializer.run(loadedSerializedRecord);
};
$hxClasses["com.dango_itimi.scenario.framework.save.Recorder"] = com_dango_$itimi_scenario_framework_save_Recorder;
com_dango_$itimi_scenario_framework_save_Recorder.__name__ = ["com","dango_itimi","scenario","framework","save","Recorder"];
com_dango_$itimi_scenario_framework_save_Recorder.prototype = {
	add: function(firedEventId) {
		this.record.firedEventIdSet.push(firedEventId);
	}
	,checkSavedEventNullError: function(eventMap) {
		var _g = 0;
		var _g1 = this.record.firedEventIdSet;
		while(_g < _g1.length) {
			var eventId = _g1[_g];
			++_g;
			if((__map_reserved[eventId] != null?eventMap.getReserved(eventId):eventMap.h[eventId]) == null) throw new js__$Boot_HaxeError(eventId + " is not found");
		}
	}
	,getRecordedEventSet: function(eventMap) {
		var eventSet = [];
		var _g = 0;
		var _g1 = this.record.firedEventIdSet;
		while(_g < _g1.length) {
			var eventId = _g1[_g];
			++_g;
			var event;
			event = __map_reserved[eventId] != null?eventMap.getReserved(eventId):eventMap.h[eventId];
			eventSet.push(event);
		}
		return eventSet;
	}
	,getSerializedRecord: function() {
		return haxe_Serializer.run(this.record);
	}
	,__class__: com_dango_$itimi_scenario_framework_save_Recorder
};
var com_dango_$itimi_scenario_framework_text_TextViewerEvent = $hxClasses["com.dango_itimi.scenario.framework.text.TextViewerEvent"] = { __ename__ : ["com","dango_itimi","scenario","framework","text","TextViewerEvent"], __constructs__ : ["NONE","VIEW"] };
com_dango_$itimi_scenario_framework_text_TextViewerEvent.NONE = ["NONE",0];
com_dango_$itimi_scenario_framework_text_TextViewerEvent.NONE.toString = $estr;
com_dango_$itimi_scenario_framework_text_TextViewerEvent.NONE.__enum__ = com_dango_$itimi_scenario_framework_text_TextViewerEvent;
com_dango_$itimi_scenario_framework_text_TextViewerEvent.VIEW = function(text,isSoundTiming) { var $x = ["VIEW",1,text,isSoundTiming]; $x.__enum__ = com_dango_$itimi_scenario_framework_text_TextViewerEvent; $x.toString = $estr; return $x; };
var com_dango_$itimi_scenario_framework_text_Subtitle = function(characterDisplayInterval,soundTiming) {
	this.set_characterDisplayInterval(characterDisplayInterval);
	this.set_soundTiming(soundTiming);
};
$hxClasses["com.dango_itimi.scenario.framework.text.Subtitle"] = com_dango_$itimi_scenario_framework_text_Subtitle;
com_dango_$itimi_scenario_framework_text_Subtitle.__name__ = ["com","dango_itimi","scenario","framework","text","Subtitle"];
com_dango_$itimi_scenario_framework_text_Subtitle.prototype = {
	getEvent: function() {
		var n = this.event;
		this.event = com_dango_$itimi_scenario_framework_text_TextViewerEvent.NONE;
		return n;
	}
	,set_characterDisplayInterval: function(characterDisplayInterval) {
		return this.characterDisplayInterval = characterDisplayInterval;
	}
	,set_soundTiming: function(soundTiming) {
		return this.soundTiming = soundTiming;
	}
	,run: function() {
		this.mainFunction();
	}
	,initialize: function(text) {
		this.text = text;
		this.event = com_dango_$itimi_scenario_framework_text_TextViewerEvent.NONE;
		this.textIndex = 0;
		this.characterDisplayIntervalCount = -1;
		this.soundTimingCount = 0;
		this.skipOrder = false;
		this.mainFunction = $bind(this,this.play);
	}
	,play: function() {
		if(this.skipOrder) {
			var text = HxOverrides.substr(this.text,this.textIndex,null);
			this.event = com_dango_$itimi_scenario_framework_text_TextViewerEvent.VIEW(text,true);
			this.mainFunction = $bind(this,this.finish);
		} else {
			if(++this.characterDisplayIntervalCount < this.characterDisplayInterval) return;
			this.characterDisplayIntervalCount = -1;
			var character = this.text.charAt(this.textIndex);
			this.textIndex++;
			var isSoundTiming = false;
			if(++this.soundTimingCount >= this.soundTiming) {
				isSoundTiming = true;
				this.soundTimingCount = 0;
			}
			this.event = com_dango_$itimi_scenario_framework_text_TextViewerEvent.VIEW(character,isSoundTiming);
			if(this.textIndex >= this.text.length) this.mainFunction = $bind(this,this.finish);
		}
	}
	,orderSkip: function() {
		this.skipOrder = true;
	}
	,finish: function() {
	}
	,isFinished: function() {
		return Reflect.compareMethods(this.mainFunction,$bind(this,this.finish));
	}
	,__class__: com_dango_$itimi_scenario_framework_text_Subtitle
	,__properties__: {set_soundTiming:"set_soundTiming",set_characterDisplayInterval:"set_characterDisplayInterval"}
};
var com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction = $hxClasses["com.dango_itimi.scenario.framework.text.SubtitleDisplayTymingInAction"] = { __ename__ : ["com","dango_itimi","scenario","framework","text","SubtitleDisplayTymingInAction"], __constructs__ : ["SAME","BEFORE","AFTER"] };
com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.SAME = ["SAME",0];
com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.SAME.toString = $estr;
com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.SAME.__enum__ = com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction;
com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.BEFORE = ["BEFORE",1];
com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.BEFORE.toString = $estr;
com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.BEFORE.__enum__ = com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction;
com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.AFTER = ["AFTER",2];
com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.AFTER.toString = $estr;
com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction.AFTER.__enum__ = com_dango_$itimi_scenario_framework_text_SubtitleDisplayTymingInAction;
var com_dango_$itimi_scenario_transition_direction_action_Mode = $hxClasses["com.dango_itimi.scenario.transition.direction.action.Mode"] = { __ename__ : ["com","dango_itimi","scenario","transition","direction","action","Mode"], __constructs__ : ["FADE_IN","FADE_OUT","FADE_CROSS"] };
com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_IN = ["FADE_IN",0];
com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_IN.toString = $estr;
com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_IN.__enum__ = com_dango_$itimi_scenario_transition_direction_action_Mode;
com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_OUT = ["FADE_OUT",1];
com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_OUT.toString = $estr;
com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_OUT.__enum__ = com_dango_$itimi_scenario_transition_direction_action_Mode;
com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_CROSS = ["FADE_CROSS",2];
com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_CROSS.toString = $estr;
com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_CROSS.__enum__ = com_dango_$itimi_scenario_transition_direction_action_Mode;
var com_dango_$itimi_scenario_transition_direction_action_FadeAction = function(fade,mode,skipPlayRoopMaxCount) {
	this.fade = fade;
	this.mode = mode;
	com_dango_$itimi_scenario_framework_direction_action_Action.call(this,skipPlayRoopMaxCount);
};
$hxClasses["com.dango_itimi.scenario.transition.direction.action.FadeAction"] = com_dango_$itimi_scenario_transition_direction_action_FadeAction;
com_dango_$itimi_scenario_transition_direction_action_FadeAction.__name__ = ["com","dango_itimi","scenario","transition","direction","action","FadeAction"];
com_dango_$itimi_scenario_transition_direction_action_FadeAction.__super__ = com_dango_$itimi_scenario_framework_direction_action_Action;
com_dango_$itimi_scenario_transition_direction_action_FadeAction.prototype = $extend(com_dango_$itimi_scenario_framework_direction_action_Action.prototype,{
	initialize: function() {
		var _g = this.mode;
		switch(_g[1]) {
		case 0:
			this.fade.initializeToFadeIn();
			break;
		case 1:
			this.fade.initializeToFadeOut();
			break;
		case 2:
			this.fade.initializeToFadeCross();
			break;
		}
		com_dango_$itimi_scenario_framework_direction_action_Action.prototype.initialize.call(this);
	}
	,play: function() {
		this.fade.run();
		if(this.fade.isFinished()) this.mainFunction = $bind(this,this.finish);
	}
	,__class__: com_dango_$itimi_scenario_transition_direction_action_FadeAction
});
var com_dango_$itimi_scenario_transition_screen_$change_Fade = function(amount,opacityMax,opacityMin) {
	if(amount == null) this.amount = com_dango_$itimi_scenario_transition_screen_$change_Fade.DEFAULT_AMOUNT; else this.amount = amount;
	if(opacityMax == null) this.opacityMax = com_dango_$itimi_scenario_transition_screen_$change_Fade.DEFAULT_OPACITY_MAX; else this.opacityMax = opacityMax;
	if(opacityMin == null) this.opacityMin = com_dango_$itimi_scenario_transition_screen_$change_Fade.DEFAULT_OPACITY_MIN; else this.opacityMin = opacityMin;
};
$hxClasses["com.dango_itimi.scenario.transition.screen_change.Fade"] = com_dango_$itimi_scenario_transition_screen_$change_Fade;
com_dango_$itimi_scenario_transition_screen_$change_Fade.__name__ = ["com","dango_itimi","scenario","transition","screen_change","Fade"];
com_dango_$itimi_scenario_transition_screen_$change_Fade.prototype = {
	initializeToFadeIn: function() {
		this.opacity = this.opacityMax;
		this.mainFunction = $bind(this,this.fadeIn);
	}
	,fadeIn: function() {
		this.opacity -= this.amount;
		if(this.opacity <= this.opacityMin) {
			this.opacity = this.opacityMin;
			this.mainFunction = $bind(this,this.finish);
		}
	}
	,initializeToFadeOut: function() {
		this.opacity = this.opacityMin;
		this.mainFunction = $bind(this,this.fadeOut);
	}
	,fadeOut: function() {
		this.opacity -= this.amount;
		if(this.opacity <= this.opacityMin) {
			this.opacity = this.opacityMin;
			this.mainFunction = $bind(this,this.finish);
		}
	}
	,initializeToFadeCross: function() {
		this.opacity = this.opacityMax;
		this.mainFunction = $bind(this,this.fadeCrossOut);
	}
	,fadeCrossOut: function() {
		this.opacity -= this.amount;
		if(this.opacity <= this.opacityMin) {
			this.opacity = this.opacityMin;
			this.mainFunction = $bind(this,this.fadeIn);
		}
	}
	,run: function() {
		this.mainFunction();
	}
	,finish: function() {
	}
	,isFinished: function() {
		return Reflect.compareMethods(this.mainFunction,$bind(this,this.finish));
	}
	,__class__: com_dango_$itimi_scenario_transition_screen_$change_Fade
};
var com_dango_$itimi_utils_MetaField = function(name,value) {
	this.name = name;
	this.value = value;
};
$hxClasses["com.dango_itimi.utils.MetaField"] = com_dango_$itimi_utils_MetaField;
com_dango_$itimi_utils_MetaField.__name__ = ["com","dango_itimi","utils","MetaField"];
com_dango_$itimi_utils_MetaField.prototype = {
	__class__: com_dango_$itimi_utils_MetaField
};
var com_dango_$itimi_utils_MetaUtil = function() { };
$hxClasses["com.dango_itimi.utils.MetaUtil"] = com_dango_$itimi_utils_MetaUtil;
com_dango_$itimi_utils_MetaUtil.__name__ = ["com","dango_itimi","utils","MetaUtil"];
com_dango_$itimi_utils_MetaUtil.getMetaFieldsWithInstance = function(instance,metaLabel) {
	return com_dango_$itimi_utils_MetaUtil.getMetaFields(instance == null?null:js_Boot.getClass(instance),metaLabel);
};
com_dango_$itimi_utils_MetaUtil.getMetaFields = function(cls,metaLabel) {
	var metaFieldSet = [];
	var metaFields = haxe_rtti_Meta.getFields(cls);
	var fieldStrings = Reflect.fields(metaFields);
	var _g = 0;
	while(_g < fieldStrings.length) {
		var fieldString = fieldStrings[_g];
		++_g;
		{
			var _g1 = com_dango_$itimi_utils_MetaUtil.hasMetaData(metaFields,fieldString,metaLabel);
			switch(_g1[1]) {
			case 1:
				continue;
				break;
			case 0:
				var metaValues = _g1[2];
				var metaField = new com_dango_$itimi_utils_MetaField(fieldString,metaValues);
				metaFieldSet.push(metaField);
				break;
			}
		}
	}
	return metaFieldSet;
};
com_dango_$itimi_utils_MetaUtil.hasMetaData = function(metaFields,fieldString,metaLabel) {
	var fieldProperty = Reflect.getProperty(metaFields,fieldString);
	var metaLabels = Reflect.fields(fieldProperty);
	var _g = 0;
	while(_g < metaLabels.length) {
		var checkedMetaDataName = metaLabels[_g];
		++_g;
		if(checkedMetaDataName == metaLabel) {
			var metaValues = Reflect.getProperty(fieldProperty,checkedMetaDataName);
			return com_dango_$itimi_utils__$MetaUtil_HasMetaDataResult.TRUE(metaValues);
		}
	}
	return com_dango_$itimi_utils__$MetaUtil_HasMetaDataResult.FALSE;
};
var com_dango_$itimi_utils__$MetaUtil_HasMetaDataResult = $hxClasses["com.dango_itimi.utils._MetaUtil.HasMetaDataResult"] = { __ename__ : ["com","dango_itimi","utils","_MetaUtil","HasMetaDataResult"], __constructs__ : ["TRUE","FALSE"] };
com_dango_$itimi_utils__$MetaUtil_HasMetaDataResult.TRUE = function(metaValues) { var $x = ["TRUE",0,metaValues]; $x.__enum__ = com_dango_$itimi_utils__$MetaUtil_HasMetaDataResult; $x.toString = $estr; return $x; };
com_dango_$itimi_utils__$MetaUtil_HasMetaDataResult.FALSE = ["FALSE",1];
com_dango_$itimi_utils__$MetaUtil_HasMetaDataResult.FALSE.toString = $estr;
com_dango_$itimi_utils__$MetaUtil_HasMetaDataResult.FALSE.__enum__ = com_dango_$itimi_utils__$MetaUtil_HasMetaDataResult;
var haxe_IMap = function() { };
$hxClasses["haxe.IMap"] = haxe_IMap;
haxe_IMap.__name__ = ["haxe","IMap"];
var haxe__$Int64__$_$_$Int64 = function(high,low) {
	this.high = high;
	this.low = low;
};
$hxClasses["haxe._Int64.___Int64"] = haxe__$Int64__$_$_$Int64;
haxe__$Int64__$_$_$Int64.__name__ = ["haxe","_Int64","___Int64"];
haxe__$Int64__$_$_$Int64.prototype = {
	__class__: haxe__$Int64__$_$_$Int64
};
var haxe_Serializer = function() {
	this.buf = new StringBuf();
	this.cache = [];
	this.useCache = haxe_Serializer.USE_CACHE;
	this.useEnumIndex = haxe_Serializer.USE_ENUM_INDEX;
	this.shash = new haxe_ds_StringMap();
	this.scount = 0;
};
$hxClasses["haxe.Serializer"] = haxe_Serializer;
haxe_Serializer.__name__ = ["haxe","Serializer"];
haxe_Serializer.run = function(v) {
	var s = new haxe_Serializer();
	s.serialize(v);
	return s.toString();
};
haxe_Serializer.prototype = {
	toString: function() {
		return this.buf.b;
	}
	,serializeString: function(s) {
		var x = this.shash.get(s);
		if(x != null) {
			this.buf.b += "R";
			if(x == null) this.buf.b += "null"; else this.buf.b += "" + x;
			return;
		}
		this.shash.set(s,this.scount++);
		this.buf.b += "y";
		s = encodeURIComponent(s);
		if(s.length == null) this.buf.b += "null"; else this.buf.b += "" + s.length;
		this.buf.b += ":";
		if(s == null) this.buf.b += "null"; else this.buf.b += "" + s;
	}
	,serializeRef: function(v) {
		var vt = typeof(v);
		var _g1 = 0;
		var _g = this.cache.length;
		while(_g1 < _g) {
			var i = _g1++;
			var ci = this.cache[i];
			if(typeof(ci) == vt && ci == v) {
				this.buf.b += "r";
				if(i == null) this.buf.b += "null"; else this.buf.b += "" + i;
				return true;
			}
		}
		this.cache.push(v);
		return false;
	}
	,serializeFields: function(v) {
		var _g = 0;
		var _g1 = Reflect.fields(v);
		while(_g < _g1.length) {
			var f = _g1[_g];
			++_g;
			this.serializeString(f);
			this.serialize(Reflect.field(v,f));
		}
		this.buf.b += "g";
	}
	,serialize: function(v) {
		{
			var _g = Type["typeof"](v);
			switch(_g[1]) {
			case 0:
				this.buf.b += "n";
				break;
			case 1:
				var v1 = v;
				if(v1 == 0) {
					this.buf.b += "z";
					return;
				}
				this.buf.b += "i";
				if(v1 == null) this.buf.b += "null"; else this.buf.b += "" + v1;
				break;
			case 2:
				var v2 = v;
				if(isNaN(v2)) this.buf.b += "k"; else if(!isFinite(v2)) if(v2 < 0) this.buf.b += "m"; else this.buf.b += "p"; else {
					this.buf.b += "d";
					if(v2 == null) this.buf.b += "null"; else this.buf.b += "" + v2;
				}
				break;
			case 3:
				if(v) this.buf.b += "t"; else this.buf.b += "f";
				break;
			case 6:
				var c = _g[2];
				if(c == String) {
					this.serializeString(v);
					return;
				}
				if(this.useCache && this.serializeRef(v)) return;
				switch(c) {
				case Array:
					var ucount = 0;
					this.buf.b += "a";
					var l = v.length;
					var _g1 = 0;
					while(_g1 < l) {
						var i = _g1++;
						if(v[i] == null) ucount++; else {
							if(ucount > 0) {
								if(ucount == 1) this.buf.b += "n"; else {
									this.buf.b += "u";
									if(ucount == null) this.buf.b += "null"; else this.buf.b += "" + ucount;
								}
								ucount = 0;
							}
							this.serialize(v[i]);
						}
					}
					if(ucount > 0) {
						if(ucount == 1) this.buf.b += "n"; else {
							this.buf.b += "u";
							if(ucount == null) this.buf.b += "null"; else this.buf.b += "" + ucount;
						}
					}
					this.buf.b += "h";
					break;
				case List:
					this.buf.b += "l";
					var v3 = v;
					var _g1_head = v3.h;
					var _g1_val = null;
					while(_g1_head != null) {
						var i1;
						_g1_val = _g1_head[0];
						_g1_head = _g1_head[1];
						i1 = _g1_val;
						this.serialize(i1);
					}
					this.buf.b += "h";
					break;
				case Date:
					var d = v;
					this.buf.b += "v";
					this.buf.add(d.getTime());
					break;
				case haxe_ds_StringMap:
					this.buf.b += "b";
					var v4 = v;
					var $it0 = v4.keys();
					while( $it0.hasNext() ) {
						var k = $it0.next();
						this.serializeString(k);
						this.serialize(__map_reserved[k] != null?v4.getReserved(k):v4.h[k]);
					}
					this.buf.b += "h";
					break;
				case haxe_ds_IntMap:
					this.buf.b += "q";
					var v5 = v;
					var $it1 = v5.keys();
					while( $it1.hasNext() ) {
						var k1 = $it1.next();
						this.buf.b += ":";
						if(k1 == null) this.buf.b += "null"; else this.buf.b += "" + k1;
						this.serialize(v5.h[k1]);
					}
					this.buf.b += "h";
					break;
				case haxe_ds_ObjectMap:
					this.buf.b += "M";
					var v6 = v;
					var $it2 = v6.keys();
					while( $it2.hasNext() ) {
						var k2 = $it2.next();
						var id = Reflect.field(k2,"__id__");
						Reflect.deleteField(k2,"__id__");
						this.serialize(k2);
						k2.__id__ = id;
						this.serialize(v6.h[k2.__id__]);
					}
					this.buf.b += "h";
					break;
				case haxe_io_Bytes:
					var v7 = v;
					var i2 = 0;
					var max = v7.length - 2;
					var charsBuf = new StringBuf();
					var b64 = haxe_Serializer.BASE64;
					while(i2 < max) {
						var b1 = v7.get(i2++);
						var b2 = v7.get(i2++);
						var b3 = v7.get(i2++);
						charsBuf.add(b64.charAt(b1 >> 2));
						charsBuf.add(b64.charAt((b1 << 4 | b2 >> 4) & 63));
						charsBuf.add(b64.charAt((b2 << 2 | b3 >> 6) & 63));
						charsBuf.add(b64.charAt(b3 & 63));
					}
					if(i2 == max) {
						var b11 = v7.get(i2++);
						var b21 = v7.get(i2++);
						charsBuf.add(b64.charAt(b11 >> 2));
						charsBuf.add(b64.charAt((b11 << 4 | b21 >> 4) & 63));
						charsBuf.add(b64.charAt(b21 << 2 & 63));
					} else if(i2 == max + 1) {
						var b12 = v7.get(i2++);
						charsBuf.add(b64.charAt(b12 >> 2));
						charsBuf.add(b64.charAt(b12 << 4 & 63));
					}
					var chars = charsBuf.b;
					this.buf.b += "s";
					if(chars.length == null) this.buf.b += "null"; else this.buf.b += "" + chars.length;
					this.buf.b += ":";
					if(chars == null) this.buf.b += "null"; else this.buf.b += "" + chars;
					break;
				default:
					if(this.useCache) this.cache.pop();
					if(v.hxSerialize != null) {
						this.buf.b += "C";
						this.serializeString(Type.getClassName(c));
						if(this.useCache) this.cache.push(v);
						v.hxSerialize(this);
						this.buf.b += "g";
					} else {
						this.buf.b += "c";
						this.serializeString(Type.getClassName(c));
						if(this.useCache) this.cache.push(v);
						this.serializeFields(v);
					}
				}
				break;
			case 4:
				if(js_Boot.__instanceof(v,Class)) {
					var className = Type.getClassName(v);
					this.buf.b += "A";
					this.serializeString(className);
				} else if(js_Boot.__instanceof(v,Enum)) {
					this.buf.b += "B";
					this.serializeString(Type.getEnumName(v));
				} else {
					if(this.useCache && this.serializeRef(v)) return;
					this.buf.b += "o";
					this.serializeFields(v);
				}
				break;
			case 7:
				var e = _g[2];
				if(this.useCache) {
					if(this.serializeRef(v)) return;
					this.cache.pop();
				}
				if(this.useEnumIndex) this.buf.b += "j"; else this.buf.b += "w";
				this.serializeString(Type.getEnumName(e));
				if(this.useEnumIndex) {
					this.buf.b += ":";
					this.buf.b += Std.string(v[1]);
				} else this.serializeString(v[0]);
				this.buf.b += ":";
				var l1 = v.length;
				this.buf.b += Std.string(l1 - 2);
				var _g11 = 2;
				while(_g11 < l1) {
					var i3 = _g11++;
					this.serialize(v[i3]);
				}
				if(this.useCache) this.cache.push(v);
				break;
			case 5:
				throw new js__$Boot_HaxeError("Cannot serialize function");
				break;
			default:
				throw new js__$Boot_HaxeError("Cannot serialize " + Std.string(v));
			}
		}
	}
	,__class__: haxe_Serializer
};
var haxe_Timer = function(time_ms) {
	var me = this;
	this.id = setInterval(function() {
		me.run();
	},time_ms);
};
$hxClasses["haxe.Timer"] = haxe_Timer;
haxe_Timer.__name__ = ["haxe","Timer"];
haxe_Timer.prototype = {
	run: function() {
	}
	,__class__: haxe_Timer
};
var haxe_Unserializer = function(buf) {
	this.buf = buf;
	this.length = buf.length;
	this.pos = 0;
	this.scache = [];
	this.cache = [];
	var r = haxe_Unserializer.DEFAULT_RESOLVER;
	if(r == null) {
		r = Type;
		haxe_Unserializer.DEFAULT_RESOLVER = r;
	}
	this.setResolver(r);
};
$hxClasses["haxe.Unserializer"] = haxe_Unserializer;
haxe_Unserializer.__name__ = ["haxe","Unserializer"];
haxe_Unserializer.initCodes = function() {
	var codes = [];
	var _g1 = 0;
	var _g = haxe_Unserializer.BASE64.length;
	while(_g1 < _g) {
		var i = _g1++;
		codes[haxe_Unserializer.BASE64.charCodeAt(i)] = i;
	}
	return codes;
};
haxe_Unserializer.run = function(v) {
	return new haxe_Unserializer(v).unserialize();
};
haxe_Unserializer.prototype = {
	setResolver: function(r) {
		if(r == null) this.resolver = { resolveClass : function(_) {
			return null;
		}, resolveEnum : function(_1) {
			return null;
		}}; else this.resolver = r;
	}
	,get: function(p) {
		return this.buf.charCodeAt(p);
	}
	,readDigits: function() {
		var k = 0;
		var s = false;
		var fpos = this.pos;
		while(true) {
			var c = this.buf.charCodeAt(this.pos);
			if(c != c) break;
			if(c == 45) {
				if(this.pos != fpos) break;
				s = true;
				this.pos++;
				continue;
			}
			if(c < 48 || c > 57) break;
			k = k * 10 + (c - 48);
			this.pos++;
		}
		if(s) k *= -1;
		return k;
	}
	,readFloat: function() {
		var p1 = this.pos;
		while(true) {
			var c = this.buf.charCodeAt(this.pos);
			if(c >= 43 && c < 58 || c == 101 || c == 69) this.pos++; else break;
		}
		return Std.parseFloat(HxOverrides.substr(this.buf,p1,this.pos - p1));
	}
	,unserializeObject: function(o) {
		while(true) {
			if(this.pos >= this.length) throw new js__$Boot_HaxeError("Invalid object");
			if(this.buf.charCodeAt(this.pos) == 103) break;
			var k = this.unserialize();
			if(!(typeof(k) == "string")) throw new js__$Boot_HaxeError("Invalid object key");
			var v = this.unserialize();
			o[k] = v;
		}
		this.pos++;
	}
	,unserializeEnum: function(edecl,tag) {
		if(this.get(this.pos++) != 58) throw new js__$Boot_HaxeError("Invalid enum format");
		var nargs = this.readDigits();
		if(nargs == 0) return Type.createEnum(edecl,tag);
		var args = [];
		while(nargs-- > 0) args.push(this.unserialize());
		return Type.createEnum(edecl,tag,args);
	}
	,unserialize: function() {
		var _g = this.get(this.pos++);
		switch(_g) {
		case 110:
			return null;
		case 116:
			return true;
		case 102:
			return false;
		case 122:
			return 0;
		case 105:
			return this.readDigits();
		case 100:
			return this.readFloat();
		case 121:
			var len = this.readDigits();
			if(this.get(this.pos++) != 58 || this.length - this.pos < len) throw new js__$Boot_HaxeError("Invalid string length");
			var s = HxOverrides.substr(this.buf,this.pos,len);
			this.pos += len;
			s = decodeURIComponent(s.split("+").join(" "));
			this.scache.push(s);
			return s;
		case 107:
			return NaN;
		case 109:
			return -Infinity;
		case 112:
			return Infinity;
		case 97:
			var buf = this.buf;
			var a = [];
			this.cache.push(a);
			while(true) {
				var c = this.buf.charCodeAt(this.pos);
				if(c == 104) {
					this.pos++;
					break;
				}
				if(c == 117) {
					this.pos++;
					var n = this.readDigits();
					a[a.length + n - 1] = null;
				} else a.push(this.unserialize());
			}
			return a;
		case 111:
			var o = { };
			this.cache.push(o);
			this.unserializeObject(o);
			return o;
		case 114:
			var n1 = this.readDigits();
			if(n1 < 0 || n1 >= this.cache.length) throw new js__$Boot_HaxeError("Invalid reference");
			return this.cache[n1];
		case 82:
			var n2 = this.readDigits();
			if(n2 < 0 || n2 >= this.scache.length) throw new js__$Boot_HaxeError("Invalid string reference");
			return this.scache[n2];
		case 120:
			throw new js__$Boot_HaxeError(this.unserialize());
			break;
		case 99:
			var name = this.unserialize();
			var cl = this.resolver.resolveClass(name);
			if(cl == null) throw new js__$Boot_HaxeError("Class not found " + name);
			var o1 = Type.createEmptyInstance(cl);
			this.cache.push(o1);
			this.unserializeObject(o1);
			return o1;
		case 119:
			var name1 = this.unserialize();
			var edecl = this.resolver.resolveEnum(name1);
			if(edecl == null) throw new js__$Boot_HaxeError("Enum not found " + name1);
			var e = this.unserializeEnum(edecl,this.unserialize());
			this.cache.push(e);
			return e;
		case 106:
			var name2 = this.unserialize();
			var edecl1 = this.resolver.resolveEnum(name2);
			if(edecl1 == null) throw new js__$Boot_HaxeError("Enum not found " + name2);
			this.pos++;
			var index = this.readDigits();
			var tag = Type.getEnumConstructs(edecl1)[index];
			if(tag == null) throw new js__$Boot_HaxeError("Unknown enum index " + name2 + "@" + index);
			var e1 = this.unserializeEnum(edecl1,tag);
			this.cache.push(e1);
			return e1;
		case 108:
			var l = new List();
			this.cache.push(l);
			var buf1 = this.buf;
			while(this.buf.charCodeAt(this.pos) != 104) l.add(this.unserialize());
			this.pos++;
			return l;
		case 98:
			var h = new haxe_ds_StringMap();
			this.cache.push(h);
			var buf2 = this.buf;
			while(this.buf.charCodeAt(this.pos) != 104) {
				var s1 = this.unserialize();
				h.set(s1,this.unserialize());
			}
			this.pos++;
			return h;
		case 113:
			var h1 = new haxe_ds_IntMap();
			this.cache.push(h1);
			var buf3 = this.buf;
			var c1 = this.get(this.pos++);
			while(c1 == 58) {
				var i = this.readDigits();
				h1.set(i,this.unserialize());
				c1 = this.get(this.pos++);
			}
			if(c1 != 104) throw new js__$Boot_HaxeError("Invalid IntMap format");
			return h1;
		case 77:
			var h2 = new haxe_ds_ObjectMap();
			this.cache.push(h2);
			var buf4 = this.buf;
			while(this.buf.charCodeAt(this.pos) != 104) {
				var s2 = this.unserialize();
				h2.set(s2,this.unserialize());
			}
			this.pos++;
			return h2;
		case 118:
			var d;
			if(this.buf.charCodeAt(this.pos) >= 48 && this.buf.charCodeAt(this.pos) <= 57 && this.buf.charCodeAt(this.pos + 1) >= 48 && this.buf.charCodeAt(this.pos + 1) <= 57 && this.buf.charCodeAt(this.pos + 2) >= 48 && this.buf.charCodeAt(this.pos + 2) <= 57 && this.buf.charCodeAt(this.pos + 3) >= 48 && this.buf.charCodeAt(this.pos + 3) <= 57 && this.buf.charCodeAt(this.pos + 4) == 45) {
				var s3 = HxOverrides.substr(this.buf,this.pos,19);
				d = HxOverrides.strDate(s3);
				this.pos += 19;
			} else {
				var t = this.readFloat();
				var d1 = new Date();
				d1.setTime(t);
				d = d1;
			}
			this.cache.push(d);
			return d;
		case 115:
			var len1 = this.readDigits();
			var buf5 = this.buf;
			if(this.get(this.pos++) != 58 || this.length - this.pos < len1) throw new js__$Boot_HaxeError("Invalid bytes length");
			var codes = haxe_Unserializer.CODES;
			if(codes == null) {
				codes = haxe_Unserializer.initCodes();
				haxe_Unserializer.CODES = codes;
			}
			var i1 = this.pos;
			var rest = len1 & 3;
			var size;
			size = (len1 >> 2) * 3 + (rest >= 2?rest - 1:0);
			var max = i1 + (len1 - rest);
			var bytes = haxe_io_Bytes.alloc(size);
			var bpos = 0;
			while(i1 < max) {
				var c11 = codes[StringTools.fastCodeAt(buf5,i1++)];
				var c2 = codes[StringTools.fastCodeAt(buf5,i1++)];
				bytes.set(bpos++,c11 << 2 | c2 >> 4);
				var c3 = codes[StringTools.fastCodeAt(buf5,i1++)];
				bytes.set(bpos++,c2 << 4 | c3 >> 2);
				var c4 = codes[StringTools.fastCodeAt(buf5,i1++)];
				bytes.set(bpos++,c3 << 6 | c4);
			}
			if(rest >= 2) {
				var c12 = codes[StringTools.fastCodeAt(buf5,i1++)];
				var c21 = codes[StringTools.fastCodeAt(buf5,i1++)];
				bytes.set(bpos++,c12 << 2 | c21 >> 4);
				if(rest == 3) {
					var c31 = codes[StringTools.fastCodeAt(buf5,i1++)];
					bytes.set(bpos++,c21 << 4 | c31 >> 2);
				}
			}
			this.pos += len1;
			this.cache.push(bytes);
			return bytes;
		case 67:
			var name3 = this.unserialize();
			var cl1 = this.resolver.resolveClass(name3);
			if(cl1 == null) throw new js__$Boot_HaxeError("Class not found " + name3);
			var o2 = Type.createEmptyInstance(cl1);
			this.cache.push(o2);
			o2.hxUnserialize(this);
			if(this.get(this.pos++) != 103) throw new js__$Boot_HaxeError("Invalid custom data");
			return o2;
		case 65:
			var name4 = this.unserialize();
			var cl2 = this.resolver.resolveClass(name4);
			if(cl2 == null) throw new js__$Boot_HaxeError("Class not found " + name4);
			return cl2;
		case 66:
			var name5 = this.unserialize();
			var e2 = this.resolver.resolveEnum(name5);
			if(e2 == null) throw new js__$Boot_HaxeError("Enum not found " + name5);
			return e2;
		default:
		}
		this.pos--;
		throw new js__$Boot_HaxeError("Invalid char " + this.buf.charAt(this.pos) + " at position " + this.pos);
	}
	,__class__: haxe_Unserializer
};
var haxe_ds_IntMap = function() {
	this.h = { };
};
$hxClasses["haxe.ds.IntMap"] = haxe_ds_IntMap;
haxe_ds_IntMap.__name__ = ["haxe","ds","IntMap"];
haxe_ds_IntMap.__interfaces__ = [haxe_IMap];
haxe_ds_IntMap.prototype = {
	set: function(key,value) {
		this.h[key] = value;
	}
	,keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key | 0);
		}
		return HxOverrides.iter(a);
	}
	,__class__: haxe_ds_IntMap
};
var haxe_ds_ObjectMap = function() {
	this.h = { };
	this.h.__keys__ = { };
};
$hxClasses["haxe.ds.ObjectMap"] = haxe_ds_ObjectMap;
haxe_ds_ObjectMap.__name__ = ["haxe","ds","ObjectMap"];
haxe_ds_ObjectMap.__interfaces__ = [haxe_IMap];
haxe_ds_ObjectMap.prototype = {
	set: function(key,value) {
		var id = key.__id__ || (key.__id__ = ++haxe_ds_ObjectMap.count);
		this.h[id] = value;
		this.h.__keys__[id] = key;
	}
	,keys: function() {
		var a = [];
		for( var key in this.h.__keys__ ) {
		if(this.h.hasOwnProperty(key)) a.push(this.h.__keys__[key]);
		}
		return HxOverrides.iter(a);
	}
	,__class__: haxe_ds_ObjectMap
};
var haxe_ds_StringMap = function() {
	this.h = { };
};
$hxClasses["haxe.ds.StringMap"] = haxe_ds_StringMap;
haxe_ds_StringMap.__name__ = ["haxe","ds","StringMap"];
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	set: function(key,value) {
		if(__map_reserved[key] != null) this.setReserved(key,value); else this.h[key] = value;
	}
	,get: function(key) {
		if(__map_reserved[key] != null) return this.getReserved(key);
		return this.h[key];
	}
	,setReserved: function(key,value) {
		if(this.rh == null) this.rh = { };
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) return null; else return this.rh["$" + key];
	}
	,keys: function() {
		var _this = this.arrayKeys();
		return HxOverrides.iter(_this);
	}
	,arrayKeys: function() {
		var out = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) out.push(key);
		}
		if(this.rh != null) {
			for( var key in this.rh ) {
			if(key.charCodeAt(0) == 36) out.push(key.substr(1));
			}
		}
		return out;
	}
	,__class__: haxe_ds_StringMap
};
var haxe_io_Bytes = function(data) {
	this.length = data.byteLength;
	this.b = new Uint8Array(data);
	this.b.bufferValue = data;
	data.hxBytes = this;
	data.bytes = this.b;
};
$hxClasses["haxe.io.Bytes"] = haxe_io_Bytes;
haxe_io_Bytes.__name__ = ["haxe","io","Bytes"];
haxe_io_Bytes.alloc = function(length) {
	return new haxe_io_Bytes(new ArrayBuffer(length));
};
haxe_io_Bytes.prototype = {
	get: function(pos) {
		return this.b[pos];
	}
	,set: function(pos,v) {
		this.b[pos] = v & 255;
	}
	,__class__: haxe_io_Bytes
};
var haxe_io_Error = $hxClasses["haxe.io.Error"] = { __ename__ : ["haxe","io","Error"], __constructs__ : ["Blocked","Overflow","OutsideBounds","Custom"] };
haxe_io_Error.Blocked = ["Blocked",0];
haxe_io_Error.Blocked.toString = $estr;
haxe_io_Error.Blocked.__enum__ = haxe_io_Error;
haxe_io_Error.Overflow = ["Overflow",1];
haxe_io_Error.Overflow.toString = $estr;
haxe_io_Error.Overflow.__enum__ = haxe_io_Error;
haxe_io_Error.OutsideBounds = ["OutsideBounds",2];
haxe_io_Error.OutsideBounds.toString = $estr;
haxe_io_Error.OutsideBounds.__enum__ = haxe_io_Error;
haxe_io_Error.Custom = function(e) { var $x = ["Custom",3,e]; $x.__enum__ = haxe_io_Error; $x.toString = $estr; return $x; };
var haxe_io_FPHelper = function() { };
$hxClasses["haxe.io.FPHelper"] = haxe_io_FPHelper;
haxe_io_FPHelper.__name__ = ["haxe","io","FPHelper"];
haxe_io_FPHelper.i32ToFloat = function(i) {
	var sign = 1 - (i >>> 31 << 1);
	var exp = i >>> 23 & 255;
	var sig = i & 8388607;
	if(sig == 0 && exp == 0) return 0.0;
	return sign * (1 + Math.pow(2,-23) * sig) * Math.pow(2,exp - 127);
};
haxe_io_FPHelper.floatToI32 = function(f) {
	if(f == 0) return 0;
	var af;
	if(f < 0) af = -f; else af = f;
	var exp = Math.floor(Math.log(af) / 0.6931471805599453);
	if(exp < -127) exp = -127; else if(exp > 128) exp = 128;
	var sig = Math.round((af / Math.pow(2,exp) - 1) * 8388608) & 8388607;
	return (f < 0?-2147483648:0) | exp + 127 << 23 | sig;
};
haxe_io_FPHelper.i64ToDouble = function(low,high) {
	var sign = 1 - (high >>> 31 << 1);
	var exp = (high >> 20 & 2047) - 1023;
	var sig = (high & 1048575) * 4294967296. + (low >>> 31) * 2147483648. + (low & 2147483647);
	if(sig == 0 && exp == -1023) return 0.0;
	return sign * (1.0 + Math.pow(2,-52) * sig) * Math.pow(2,exp);
};
haxe_io_FPHelper.doubleToI64 = function(v) {
	var i64 = haxe_io_FPHelper.i64tmp;
	if(v == 0) {
		i64.low = 0;
		i64.high = 0;
	} else {
		var av;
		if(v < 0) av = -v; else av = v;
		var exp = Math.floor(Math.log(av) / 0.6931471805599453);
		var sig;
		var v1 = (av / Math.pow(2,exp) - 1) * 4503599627370496.;
		sig = Math.round(v1);
		var sig_l = sig | 0;
		var sig_h = sig / 4294967296.0 | 0;
		i64.low = sig_l;
		i64.high = (v < 0?-2147483648:0) | exp + 1023 << 20 | sig_h;
	}
	return i64;
};
var haxe_rtti_Meta = function() { };
$hxClasses["haxe.rtti.Meta"] = haxe_rtti_Meta;
haxe_rtti_Meta.__name__ = ["haxe","rtti","Meta"];
haxe_rtti_Meta.getMeta = function(t) {
	return t.__meta__;
};
haxe_rtti_Meta.getFields = function(t) {
	var meta = haxe_rtti_Meta.getMeta(t);
	if(meta == null || meta.fields == null) return { }; else return meta.fields;
};
var haxegame_Main = function() {
	var _g = this;
	this.click = new haxegame_dom_Click();
	this.game = new haxegame_game_Game();
	this.timer = new haxe_Timer(1 / haxegame_Main.FPS * 1000 | 0);
	this.timer.run = function() {
		_g.run();
	};
};
$hxClasses["haxegame.Main"] = haxegame_Main;
haxegame_Main.__name__ = ["haxegame","Main"];
haxegame_Main.main = function() {
	$(function() {
		new haxegame_Main();
	});
};
haxegame_Main.prototype = {
	run: function() {
		this.game.run();
		var clickPosition = this.click.getPosition();
		if(clickPosition != null) this.game.operateClick(clickPosition);
	}
	,__class__: haxegame_Main
};
var haxegame_dom_Click = function() {
	var _g = this;
	this.position = null;
	var root;
	if(haxegame_dom_Root.instance == null) root = haxegame_dom_Root.instance = new haxegame_dom_Root(); else root = haxegame_dom_Root.instance;
	var rootElement = root.jQueryElement;
	rootElement.click(function(event) {
		_g.position = { x : event.pageX - root.elementPositionX, y : event.pageY - root.elementPositionY};
	});
};
$hxClasses["haxegame.dom.Click"] = haxegame_dom_Click;
haxegame_dom_Click.__name__ = ["haxegame","dom","Click"];
haxegame_dom_Click.prototype = {
	getPosition: function() {
		var n = this.position;
		this.position = null;
		return n;
	}
	,__class__: haxegame_dom_Click
};
var haxegame_dom_JQueryElement = function() { };
$hxClasses["haxegame.dom.JQueryElement"] = haxegame_dom_JQueryElement;
haxegame_dom_JQueryElement.__name__ = ["haxegame","dom","JQueryElement"];
haxegame_dom_JQueryElement.createWithId = function(elementId) {
	return haxegame_dom_JQueryElement.create("#" + elementId);
};
haxegame_dom_JQueryElement.createWithClass = function(elementClass,parentElement) {
	return haxegame_dom_JQueryElement.create("." + elementClass,parentElement);
};
haxegame_dom_JQueryElement.create = function(elementId,parentElement) {
	if(parentElement != null) return $(elementId); else return $(elementId,parentElement);
};
haxegame_dom_JQueryElement.setOpacity = function(element,opacity) {
	element.css({ opacity : opacity});
};
haxegame_dom_JQueryElement.appendText = function(element,text) {
	element.text(element.text() + text);
};
haxegame_dom_JQueryElement.setText = function(element,text) {
	element.text(text);
};
haxegame_dom_JQueryElement.getRectangle = function(element) {
	var position = element.position();
	return com_dango_$itimi_geom_RectangleUtil.create(position.left,position.top,element.width(),element.height());
};
var haxegame_dom_Root = function() {
	this.jQueryElement = haxegame_dom_JQueryElement.createWithId("root");
	var position = this.jQueryElement.position();
	this.elementPositionX = position.left;
	this.elementPositionY = position.top;
	this.blackScreen = haxegame_dom_JQueryElement.createWithId("black_screen");
	this.subtitle = haxegame_dom_JQueryElement.createWithId("subtitle");
	this.clickArea = new haxegame_dom_ClickArea();
};
$hxClasses["haxegame.dom.Root"] = haxegame_dom_Root;
haxegame_dom_Root.__name__ = ["haxegame","dom","Root"];
haxegame_dom_Root.__properties__ = {get_instance:"get_instance"}
haxegame_dom_Root.get_instance = function() {
	if(haxegame_dom_Root.instance == null) return haxegame_dom_Root.instance = new haxegame_dom_Root(); else return haxegame_dom_Root.instance;
};
haxegame_dom_Root.prototype = {
	__class__: haxegame_dom_Root
};
var haxegame_dom_ClickArea = function() {
	this.jQueryElement = haxegame_dom_JQueryElement.createWithId("click_area_scene1");
	this.scene1 = new haxegame_dom_Scene1(this.jQueryElement);
};
$hxClasses["haxegame.dom.ClickArea"] = haxegame_dom_ClickArea;
haxegame_dom_ClickArea.__name__ = ["haxegame","dom","ClickArea"];
haxegame_dom_ClickArea.prototype = {
	__class__: haxegame_dom_ClickArea
};
var haxegame_dom_Scene1 = function(parentElement) {
	this.jQueryElement = haxegame_dom_JQueryElement.createWithClass("scene1",parentElement);
	this.table = haxegame_dom_JQueryElement.createWithClass("table",this.jQueryElement);
	this.bed = haxegame_dom_JQueryElement.createWithClass("bed",this.jQueryElement);
};
$hxClasses["haxegame.dom.Scene1"] = haxegame_dom_Scene1;
haxegame_dom_Scene1.__name__ = ["haxegame","dom","Scene1"];
haxegame_dom_Scene1.prototype = {
	__class__: haxegame_dom_Scene1
};
var haxegame_game_ActionUpdaterMap = function(actions,updaters) {
	this.map = new haxe_ds_ObjectMap();
	actions.blackScreenFadeInAction = new com_dango_$itimi_scenario_transition_direction_action_FadeAction(updaters.blackScreen.fade,com_dango_$itimi_scenario_transition_direction_action_Mode.FADE_IN);
	this.map.set(actions.blackScreenFadeInAction,[updaters.blackScreen]);
};
$hxClasses["haxegame.game.ActionUpdaterMap"] = haxegame_game_ActionUpdaterMap;
haxegame_game_ActionUpdaterMap.__name__ = ["haxegame","game","ActionUpdaterMap"];
haxegame_game_ActionUpdaterMap.prototype = {
	update: function(action) {
		if(this.map.h[action.__id__] == null) return;
		var updaterSet = this.map.h[action.__id__];
		var _g = 0;
		while(_g < updaterSet.length) {
			var updater = updaterSet[_g];
			++_g;
			updater.update();
		}
	}
	,__class__: haxegame_game_ActionUpdaterMap
};
var haxegame_game_Actions = function() {
};
$hxClasses["haxegame.game.Actions"] = haxegame_game_Actions;
haxegame_game_Actions.__name__ = ["haxegame","game","Actions"];
haxegame_game_Actions.prototype = {
	__class__: haxegame_game_Actions
};
var haxegame_game_Game = function() {
	this.translator = new haxegame_game_subtitle_Translator();
	this.actions = new haxegame_game_Actions();
	this.updaters = new haxegame_game_Updaters();
	this.actionUpdaterMap = new haxegame_game_ActionUpdaterMap(this.actions,this.updaters);
	this.interactions = new haxegame_game_Interactions();
	this.eventAreaConverter = new haxegame_game_area_EventAreaConverter();
	this.items = new haxegame_game_scenario_Items();
	this.inventory = new com_dango_$itimi_scenario_framework_item_Inventory();
	this.directionMap = new com_dango_$itimi_scenario_framework_direction_DirectionMap();
	this.areaManager = new com_dango_$itimi_scenario_framework_area_AreaManager();
	this.scenarioWriter = new haxegame_game_scenario_Writer(this.items,this.inventory,this.directionMap,this.eventAreaConverter.eventAreas,this.areaManager,this.actions,this.interactions);
	this.director = new com_dango_$itimi_scenario_framework_Director(this.inventory,this.directionMap,this.areaManager);
	this.projector = new com_dango_$itimi_scenario_framework_Projector(this.translator.subtitle);
	com_dango_$itimi_scenario_framework_Appraiser.checkUnsetDirection(this.scenarioWriter.chapter,this.directionMap);
	com_dango_$itimi_scenario_framework_Appraiser.checkUnsetEventIdInAreaMap(this.scenarioWriter.chapter,this.areaManager);
	this.initializeToWaitUserControl();
};
$hxClasses["haxegame.game.Game"] = haxegame_game_Game;
haxegame_game_Game.__name__ = ["haxegame","game","Game"];
haxegame_game_Game.prototype = {
	run: function() {
		this.mainFunction();
	}
	,operateClick: function(clickPosition) {
		this.clickPosition = clickPosition;
	}
	,initializeToWaitUserControl: function() {
		this.clickPosition = null;
		this.mainFunction = $bind(this,this.waitUserControl);
	}
	,waitUserControl: function() {
		if(this.clickPosition == null) return;
		var scene = this.scenarioWriter.chapter.scene1;
		var film = this.director.progress(scene,this.clickPosition);
		if(film != null) this.initializeToProject(film);
	}
	,initializeToProject: function(film) {
		this.clickPosition = null;
		this.projector.initialize(film);
		this.mainFunction = $bind(this,this.project);
	}
	,project: function() {
		this.checkClick();
		this.projector.run();
		this.update();
		{
			var _g = this.projector.getEvent();
			switch(_g[1]) {
			case 0:
				return;
			case 1:
				var cutStart = _g[2];
				this.translator.reset();
				switch(cutStart[1]) {
				case 1:
					var itemChange = cutStart[2];
					this.inventory.change(itemChange);
					switch(itemChange[1]) {
					case 0:
						var itemSet = itemChange[2];
						break;
					case 1:
						var itemSet1 = itemChange[2];
						break;
					case 2:
						var removed = itemChange[3];
						var pickedUp = itemChange[2];
						break;
					}
					break;
				case 2:
					var incorrectItem = cutStart[2];
					break;
				case 0:
					"";
					break;
				}
				break;
			case 2:
				this.initializeToWaitUserControl();
				break;
			}
		}
	}
	,checkClick: function() {
		if(this.clickPosition == null) return;
		this.interactions.clickOperation.set_clicked(true);
	}
	,update: function() {
		var cut = this.projector.displayCut;
		if(cut.action != null) this.actionUpdaterMap.update(cut.action);
		if(cut.text != null) this.translator.update();
	}
	,__class__: haxegame_game_Game
};
var haxegame_game_IUpdater = function() { };
$hxClasses["haxegame.game.IUpdater"] = haxegame_game_IUpdater;
haxegame_game_IUpdater.__name__ = ["haxegame","game","IUpdater"];
haxegame_game_IUpdater.prototype = {
	__class__: haxegame_game_IUpdater
};
var haxegame_game_Interactions = function() {
	this.clickOperation = new com_dango_$itimi_scenario_framework_direction_interaction_ClickOperation();
};
$hxClasses["haxegame.game.Interactions"] = haxegame_game_Interactions;
haxegame_game_Interactions.__name__ = ["haxegame","game","Interactions"];
haxegame_game_Interactions.prototype = {
	__class__: haxegame_game_Interactions
};
var haxegame_game_Updaters = function() {
	this.blackScreen = new haxegame_game_screen_$change_BlackScreen();
};
$hxClasses["haxegame.game.Updaters"] = haxegame_game_Updaters;
haxegame_game_Updaters.__name__ = ["haxegame","game","Updaters"];
haxegame_game_Updaters.prototype = {
	__class__: haxegame_game_Updaters
};
var haxegame_game_area_EventAreaConverter = function() {
	this.eventAreas = new haxegame_game_area_EventAreas();
	var clickArea;
	clickArea = (haxegame_dom_Root.instance == null?haxegame_dom_Root.instance = new haxegame_dom_Root():haxegame_dom_Root.instance).clickArea;
	this.eventAreas.table = haxegame_dom_JQueryElement.getRectangle(clickArea.scene1.table);
	this.eventAreas.bed = haxegame_dom_JQueryElement.getRectangle(clickArea.scene1.bed);
};
$hxClasses["haxegame.game.area.EventAreaConverter"] = haxegame_game_area_EventAreaConverter;
haxegame_game_area_EventAreaConverter.__name__ = ["haxegame","game","area","EventAreaConverter"];
haxegame_game_area_EventAreaConverter.prototype = {
	__class__: haxegame_game_area_EventAreaConverter
};
var haxegame_game_area_EventAreas = function() {
};
$hxClasses["haxegame.game.area.EventAreas"] = haxegame_game_area_EventAreas;
haxegame_game_area_EventAreas.__name__ = ["haxegame","game","area","EventAreas"];
haxegame_game_area_EventAreas.prototype = {
	__class__: haxegame_game_area_EventAreas
};
var haxegame_game_scenario_Chapter = function() {
	com_dango_$itimi_scenario_core_Sequence.call(this);
};
$hxClasses["haxegame.game.scenario.Chapter"] = haxegame_game_scenario_Chapter;
haxegame_game_scenario_Chapter.__name__ = ["haxegame","game","scenario","Chapter"];
haxegame_game_scenario_Chapter.__super__ = com_dango_$itimi_scenario_core_Sequence;
haxegame_game_scenario_Chapter.prototype = $extend(com_dango_$itimi_scenario_core_Sequence.prototype,{
	__class__: haxegame_game_scenario_Chapter
});
var haxegame_game_scenario_Scene1 = function() {
	com_dango_$itimi_scenario_core_Scene.call(this);
};
$hxClasses["haxegame.game.scenario.Scene1"] = haxegame_game_scenario_Scene1;
haxegame_game_scenario_Scene1.__name__ = ["haxegame","game","scenario","Scene1"];
haxegame_game_scenario_Scene1.__super__ = com_dango_$itimi_scenario_core_Scene;
haxegame_game_scenario_Scene1.prototype = $extend(com_dango_$itimi_scenario_core_Scene.prototype,{
	__class__: haxegame_game_scenario_Scene1
});
var haxegame_game_scenario_Scene2 = function() {
	com_dango_$itimi_scenario_core_Scene.call(this);
};
$hxClasses["haxegame.game.scenario.Scene2"] = haxegame_game_scenario_Scene2;
haxegame_game_scenario_Scene2.__name__ = ["haxegame","game","scenario","Scene2"];
haxegame_game_scenario_Scene2.__super__ = com_dango_$itimi_scenario_core_Scene;
haxegame_game_scenario_Scene2.prototype = $extend(com_dango_$itimi_scenario_core_Scene.prototype,{
	__class__: haxegame_game_scenario_Scene2
});
var haxegame_game_scenario_Episode = function() {
	this.clickOperation = new com_dango_$itimi_scenario_framework_direction_interaction_ClickOperation();
};
$hxClasses["haxegame.game.scenario.Episode"] = haxegame_game_scenario_Episode;
haxegame_game_scenario_Episode.__name__ = ["haxegame","game","scenario","Episode"];
haxegame_game_scenario_Episode.prototype = {
	write: function() {
	}
	,__class__: haxegame_game_scenario_Episode
};
var haxegame_game_scenario_Episode1 = function() {
	haxegame_game_scenario_Episode.call(this);
};
$hxClasses["haxegame.game.scenario.Episode1"] = haxegame_game_scenario_Episode1;
haxegame_game_scenario_Episode1.__name__ = ["haxegame","game","scenario","Episode1"];
haxegame_game_scenario_Episode1.__super__ = haxegame_game_scenario_Episode;
haxegame_game_scenario_Episode1.prototype = $extend(haxegame_game_scenario_Episode.prototype,{
	write: function() {
		this.setApple();
		this.setOrange();
		this.setBanana();
	}
	,setApple: function() {
		var event = this.chapter.scene1.apple;
		event.enable();
		this.areaManager.set(this.eventAreas.table,event);
		var cut = new com_dango_$itimi_scenario_framework_direction_Cut(this.clickOperation,null,new com_dango_$itimi_scenario_framework_direction_action_Action(),"おはよう");
		var firedFilm = new com_dango_$itimi_scenario_framework_direction_FiredFilm(cut);
		event.enabledEventsAfterCompletion = [this.chapter.scene1.orange];
		event.disenabledEventsAfterCompletion = [this.chapter.scene2.table];
		this.directionMap.set(event,firedFilm);
	}
	,setOrange: function() {
		var event = this.chapter.scene1.orange;
		this.areaManager.set(this.eventAreas.table,event);
		event.enabledEventsAfterCompletion = [this.chapter.scene1.banana];
		var itemChangeCut = new com_dango_$itimi_scenario_framework_direction_ItemChangeCut(com_dango_$itimi_scenario_framework_item_ItemChange.PICKED_UP([this.items.sword]),this.clickOperation,null,null,"You got a " + this.items.sword.name);
		var firedFilm = new com_dango_$itimi_scenario_framework_direction_FiredFilm(itemChangeCut);
		this.directionMap.set(event,firedFilm);
	}
	,setBanana: function() {
		var event = this.chapter.scene1.banana;
		this.areaManager.set(this.eventAreas.bed,event);
		event.requiredCompletionEvents = [this.items.sword];
		event.enabledEventsAfterCompletion = [this.chapter.scene1.apple,this.chapter.scene2.table];
		var itemChangeCut = new com_dango_$itimi_scenario_framework_direction_ItemChangeCut(com_dango_$itimi_scenario_framework_item_ItemChange.EXCHANGED([this.items.shield],[this.items.sword]),this.clickOperation,null,null,"You used a " + this.items.sword.name);
		var firedFilm = new com_dango_$itimi_scenario_framework_direction_FiredFilm(itemChangeCut);
		this.directionMap.set(event,firedFilm);
	}
	,__class__: haxegame_game_scenario_Episode1
});
var haxegame_game_scenario_Episode2 = function() {
	haxegame_game_scenario_Episode.call(this);
};
$hxClasses["haxegame.game.scenario.Episode2"] = haxegame_game_scenario_Episode2;
haxegame_game_scenario_Episode2.__name__ = ["haxegame","game","scenario","Episode2"];
haxegame_game_scenario_Episode2.__super__ = haxegame_game_scenario_Episode;
haxegame_game_scenario_Episode2.prototype = $extend(haxegame_game_scenario_Episode.prototype,{
	write: function() {
		this.setTable();
		this.setBed();
	}
	,setTable: function() {
		var event = this.chapter.scene2.table;
		event.enable();
		this.areaManager.set(this.eventAreas.table,event);
		event.requiredCompletionEvents = [this.items.sword];
		event.enabledEventsAfterCompletion = [this.chapter.scene2.bed];
		var cut = new com_dango_$itimi_scenario_framework_direction_Cut(this.clickOperation,null,new com_dango_$itimi_scenario_framework_direction_action_Action());
		var firedFilm = new com_dango_$itimi_scenario_framework_direction_FiredFilm(cut);
		var cut1 = new com_dango_$itimi_scenario_framework_direction_Cut(this.clickOperation,null,new com_dango_$itimi_scenario_framework_direction_action_Action());
		var equipedIncorrectItemFilm = new com_dango_$itimi_scenario_framework_direction_EquipedIncorrectItemFilm(cut1,this.items.shield,0);
		this.directionMap.set(event,firedFilm,null,equipedIncorrectItemFilm);
	}
	,setBed: function() {
		var event = this.chapter.scene2.bed;
		this.areaManager.set(this.eventAreas.bed,event);
		event.requiredCompletionEvents = [this.items.shield];
		var itemChangeCut = new com_dango_$itimi_scenario_framework_direction_ItemChangeCut(com_dango_$itimi_scenario_framework_item_ItemChange.REMOVED([this.items.shield]),this.clickOperation,null,null,"You used a " + this.items.shield.name);
		var cut = new com_dango_$itimi_scenario_framework_direction_Cut(this.clickOperation,null,new com_dango_$itimi_scenario_framework_direction_action_Action());
		var firedFilm = new com_dango_$itimi_scenario_framework_direction_FiredFilm(itemChangeCut);
		firedFilm.add(cut);
		this.directionMap.set(event,firedFilm);
	}
	,__class__: haxegame_game_scenario_Episode2
});
var haxegame_game_scenario_Items = function() {
	this.autoCreationEventInstanceClass = com_dango_$itimi_scenario_framework_item_Item;
	com_dango_$itimi_scenario_core_Scene.call(this);
	this.sword.initialize("SWORD");
	this.shield.initialize("SHIELD");
};
$hxClasses["haxegame.game.scenario.Items"] = haxegame_game_scenario_Items;
haxegame_game_scenario_Items.__name__ = ["haxegame","game","scenario","Items"];
haxegame_game_scenario_Items.__super__ = com_dango_$itimi_scenario_core_Scene;
haxegame_game_scenario_Items.prototype = $extend(com_dango_$itimi_scenario_core_Scene.prototype,{
	__class__: haxegame_game_scenario_Items
});
var haxegame_game_scenario_Writer = function(items,inventory,directionMap,eventAreaSprite,areaManager,actions,interactions) {
	this.items = items;
	this.inventory = inventory;
	this.directionMap = directionMap;
	this.eventAreas = eventAreaSprite;
	this.areaManager = areaManager;
	this.actions = actions;
	this.interactions = interactions;
	this.chapter = new haxegame_game_scenario_Chapter();
	areaManager.register(this.chapter);
	this.episodeSet = [];
	this.execute(haxegame_game_scenario_Episode1);
	this.execute(haxegame_game_scenario_Episode2);
};
$hxClasses["haxegame.game.scenario.Writer"] = haxegame_game_scenario_Writer;
haxegame_game_scenario_Writer.__name__ = ["haxegame","game","scenario","Writer"];
haxegame_game_scenario_Writer.prototype = {
	execute: function(episodeClass) {
		var episode = Type.createInstance(episodeClass,[]);
		episode.inventory = this.inventory;
		episode.directionMap = this.directionMap;
		episode.eventAreas = this.eventAreas;
		episode.chapter = this.chapter;
		episode.items = this.items;
		episode.areaManager = this.areaManager;
		episode.actions = this.actions;
		episode.interactions = this.interactions;
		episode.write();
		this.episodeSet.push(episode);
	}
	,__class__: haxegame_game_scenario_Writer
};
var haxegame_game_screen_$change_BlackScreen = function() {
	this.jQueryElement = (haxegame_dom_Root.instance == null?haxegame_dom_Root.instance = new haxegame_dom_Root():haxegame_dom_Root.instance).blackScreen;
	this.fade = new com_dango_$itimi_scenario_transition_screen_$change_Fade(0.1,1,0);
};
$hxClasses["haxegame.game.screen_change.BlackScreen"] = haxegame_game_screen_$change_BlackScreen;
haxegame_game_screen_$change_BlackScreen.__name__ = ["haxegame","game","screen_change","BlackScreen"];
haxegame_game_screen_$change_BlackScreen.__interfaces__ = [haxegame_game_IUpdater];
haxegame_game_screen_$change_BlackScreen.prototype = {
	update: function() {
		haxegame_dom_JQueryElement.setOpacity(this.jQueryElement,this.fade.opacity);
	}
	,__class__: haxegame_game_screen_$change_BlackScreen
};
var haxegame_game_subtitle_Translator = function() {
	this.subtitle = new com_dango_$itimi_scenario_framework_text_Subtitle(1,1);
	this.jQueryElement = (haxegame_dom_Root.instance == null?haxegame_dom_Root.instance = new haxegame_dom_Root():haxegame_dom_Root.instance).subtitle;
};
$hxClasses["haxegame.game.subtitle.Translator"] = haxegame_game_subtitle_Translator;
haxegame_game_subtitle_Translator.__name__ = ["haxegame","game","subtitle","Translator"];
haxegame_game_subtitle_Translator.__interfaces__ = [haxegame_game_IUpdater];
haxegame_game_subtitle_Translator.prototype = {
	update: function() {
		{
			var _g = this.subtitle.getEvent();
			switch(_g[1]) {
			case 0:
				return;
			case 1:
				var isSoundTiming = _g[3];
				var text = _g[2];
				haxegame_dom_JQueryElement.appendText(this.jQueryElement,text);
				if(isSoundTiming) {
				}
				break;
			}
		}
	}
	,reset: function() {
		haxegame_dom_JQueryElement.setText(this.jQueryElement,"");
	}
	,__class__: haxegame_game_subtitle_Translator
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
$hxClasses["js._Boot.HaxeError"] = js__$Boot_HaxeError;
js__$Boot_HaxeError.__name__ = ["js","_Boot","HaxeError"];
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
	__class__: js__$Boot_HaxeError
});
var js_Boot = function() { };
$hxClasses["js.Boot"] = js_Boot;
js_Boot.__name__ = ["js","Boot"];
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else {
		var cl = o.__class__;
		if(cl != null) return cl;
		var name = js_Boot.__nativeClassName(o);
		if(name != null) return js_Boot.__resolveNativeClass(name);
		return null;
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js_Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js_Boot.__interfLoop(js_Boot.getClass(o),cl)) return true;
			} else if(typeof(cl) == "object" && js_Boot.__isNativeObj(cl)) {
				if(o instanceof cl) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js_Boot.__cast = function(o,t) {
	if(js_Boot.__instanceof(o,t)) return o; else throw new js__$Boot_HaxeError("Cannot cast " + Std.string(o) + " to " + Std.string(t));
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") return null;
	return name;
};
js_Boot.__isNativeObj = function(o) {
	return js_Boot.__nativeClassName(o) != null;
};
js_Boot.__resolveNativeClass = function(name) {
	return $global[name];
};
var js_html_compat_ArrayBuffer = function(a) {
	if((a instanceof Array) && a.__enum__ == null) {
		this.a = a;
		this.byteLength = a.length;
	} else {
		var len = a;
		this.a = [];
		var _g = 0;
		while(_g < len) {
			var i = _g++;
			this.a[i] = 0;
		}
		this.byteLength = len;
	}
};
$hxClasses["js.html.compat.ArrayBuffer"] = js_html_compat_ArrayBuffer;
js_html_compat_ArrayBuffer.__name__ = ["js","html","compat","ArrayBuffer"];
js_html_compat_ArrayBuffer.sliceImpl = function(begin,end) {
	var u = new Uint8Array(this,begin,end == null?null:end - begin);
	var result = new ArrayBuffer(u.byteLength);
	var resultArray = new Uint8Array(result);
	resultArray.set(u);
	return result;
};
js_html_compat_ArrayBuffer.prototype = {
	slice: function(begin,end) {
		return new js_html_compat_ArrayBuffer(this.a.slice(begin,end));
	}
	,__class__: js_html_compat_ArrayBuffer
};
var js_html_compat_DataView = function(buffer,byteOffset,byteLength) {
	this.buf = buffer;
	if(byteOffset == null) this.offset = 0; else this.offset = byteOffset;
	if(byteLength == null) this.length = buffer.byteLength - this.offset; else this.length = byteLength;
	if(this.offset < 0 || this.length < 0 || this.offset + this.length > buffer.byteLength) throw new js__$Boot_HaxeError(haxe_io_Error.OutsideBounds);
};
$hxClasses["js.html.compat.DataView"] = js_html_compat_DataView;
js_html_compat_DataView.__name__ = ["js","html","compat","DataView"];
js_html_compat_DataView.prototype = {
	getInt8: function(byteOffset) {
		var v = this.buf.a[this.offset + byteOffset];
		if(v >= 128) return v - 256; else return v;
	}
	,getUint8: function(byteOffset) {
		return this.buf.a[this.offset + byteOffset];
	}
	,getInt16: function(byteOffset,littleEndian) {
		var v = this.getUint16(byteOffset,littleEndian);
		if(v >= 32768) return v - 65536; else return v;
	}
	,getUint16: function(byteOffset,littleEndian) {
		if(littleEndian) return this.buf.a[this.offset + byteOffset] | this.buf.a[this.offset + byteOffset + 1] << 8; else return this.buf.a[this.offset + byteOffset] << 8 | this.buf.a[this.offset + byteOffset + 1];
	}
	,getInt32: function(byteOffset,littleEndian) {
		var p = this.offset + byteOffset;
		var a = this.buf.a[p++];
		var b = this.buf.a[p++];
		var c = this.buf.a[p++];
		var d = this.buf.a[p++];
		if(littleEndian) return a | b << 8 | c << 16 | d << 24; else return d | c << 8 | b << 16 | a << 24;
	}
	,getUint32: function(byteOffset,littleEndian) {
		var v = this.getInt32(byteOffset,littleEndian);
		if(v < 0) return v + 4294967296.; else return v;
	}
	,getFloat32: function(byteOffset,littleEndian) {
		return haxe_io_FPHelper.i32ToFloat(this.getInt32(byteOffset,littleEndian));
	}
	,getFloat64: function(byteOffset,littleEndian) {
		var a = this.getInt32(byteOffset,littleEndian);
		var b = this.getInt32(byteOffset + 4,littleEndian);
		return haxe_io_FPHelper.i64ToDouble(littleEndian?a:b,littleEndian?b:a);
	}
	,setInt8: function(byteOffset,value) {
		if(value < 0) this.buf.a[byteOffset + this.offset] = value + 128 & 255; else this.buf.a[byteOffset + this.offset] = value & 255;
	}
	,setUint8: function(byteOffset,value) {
		this.buf.a[byteOffset + this.offset] = value & 255;
	}
	,setInt16: function(byteOffset,value,littleEndian) {
		this.setUint16(byteOffset,value < 0?value + 65536:value,littleEndian);
	}
	,setUint16: function(byteOffset,value,littleEndian) {
		var p = byteOffset + this.offset;
		if(littleEndian) {
			this.buf.a[p] = value & 255;
			this.buf.a[p++] = value >> 8 & 255;
		} else {
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p] = value & 255;
		}
	}
	,setInt32: function(byteOffset,value,littleEndian) {
		this.setUint32(byteOffset,value,littleEndian);
	}
	,setUint32: function(byteOffset,value,littleEndian) {
		var p = byteOffset + this.offset;
		if(littleEndian) {
			this.buf.a[p++] = value & 255;
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p++] = value >> 16 & 255;
			this.buf.a[p++] = value >>> 24;
		} else {
			this.buf.a[p++] = value >>> 24;
			this.buf.a[p++] = value >> 16 & 255;
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p++] = value & 255;
		}
	}
	,setFloat32: function(byteOffset,value,littleEndian) {
		this.setUint32(byteOffset,haxe_io_FPHelper.floatToI32(value),littleEndian);
	}
	,setFloat64: function(byteOffset,value,littleEndian) {
		var i64 = haxe_io_FPHelper.doubleToI64(value);
		if(littleEndian) {
			this.setUint32(byteOffset,i64.low);
			this.setUint32(byteOffset,i64.high);
		} else {
			this.setUint32(byteOffset,i64.high);
			this.setUint32(byteOffset,i64.low);
		}
	}
	,__class__: js_html_compat_DataView
};
var js_html_compat_Uint8Array = function() { };
$hxClasses["js.html.compat.Uint8Array"] = js_html_compat_Uint8Array;
js_html_compat_Uint8Array.__name__ = ["js","html","compat","Uint8Array"];
js_html_compat_Uint8Array._new = function(arg1,offset,length) {
	var arr;
	if(typeof(arg1) == "number") {
		arr = [];
		var _g = 0;
		while(_g < arg1) {
			var i = _g++;
			arr[i] = 0;
		}
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else if(js_Boot.__instanceof(arg1,js_html_compat_ArrayBuffer)) {
		var buffer = arg1;
		if(offset == null) offset = 0;
		if(length == null) length = buffer.byteLength - offset;
		if(offset == 0) arr = buffer.a; else arr = buffer.a.slice(offset,offset + length);
		arr.byteLength = arr.length;
		arr.byteOffset = offset;
		arr.buffer = buffer;
	} else if((arg1 instanceof Array) && arg1.__enum__ == null) {
		arr = arg1.slice();
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else throw new js__$Boot_HaxeError("TODO " + Std.string(arg1));
	arr.subarray = js_html_compat_Uint8Array._subarray;
	arr.set = js_html_compat_Uint8Array._set;
	return arr;
};
js_html_compat_Uint8Array._set = function(arg,offset) {
	var t = this;
	if(js_Boot.__instanceof(arg.buffer,js_html_compat_ArrayBuffer)) {
		var a = arg;
		if(arg.byteLength + offset > t.byteLength) throw new js__$Boot_HaxeError("set() outside of range");
		var _g1 = 0;
		var _g = arg.byteLength;
		while(_g1 < _g) {
			var i = _g1++;
			t[i + offset] = a[i];
		}
	} else if((arg instanceof Array) && arg.__enum__ == null) {
		var a1 = arg;
		if(a1.length + offset > t.byteLength) throw new js__$Boot_HaxeError("set() outside of range");
		var _g11 = 0;
		var _g2 = a1.length;
		while(_g11 < _g2) {
			var i1 = _g11++;
			t[i1 + offset] = a1[i1];
		}
	} else throw new js__$Boot_HaxeError("TODO");
};
js_html_compat_Uint8Array._subarray = function(start,end) {
	var t = this;
	var a = js_html_compat_Uint8Array._new(t.slice(start,end));
	a.byteOffset = start;
	return a;
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
$hxClasses.Math = Math;
String.prototype.__class__ = $hxClasses.String = String;
String.__name__ = ["String"];
$hxClasses.Array = Array;
Array.__name__ = ["Array"];
Date.prototype.__class__ = $hxClasses.Date = Date;
Date.__name__ = ["Date"];
var Int = $hxClasses.Int = { __name__ : ["Int"]};
var Dynamic = $hxClasses.Dynamic = { __name__ : ["Dynamic"]};
var Float = $hxClasses.Float = Number;
Float.__name__ = ["Float"];
var Bool = $hxClasses.Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = $hxClasses.Class = { __name__ : ["Class"]};
var Enum = { };
var __map_reserved = {}
var ArrayBuffer = $global.ArrayBuffer || js_html_compat_ArrayBuffer;
if(ArrayBuffer.prototype.slice == null) ArrayBuffer.prototype.slice = js_html_compat_ArrayBuffer.sliceImpl;
var DataView = $global.DataView || js_html_compat_DataView;
var Uint8Array = $global.Uint8Array || js_html_compat_Uint8Array._new;
com_dango_$itimi_scenario_core_Scene.META_EVENT = "event";
com_dango_$itimi_scenario_core_Sequence.META_SCENE = "scene";
com_dango_$itimi_scenario_framework_direction_action_Action.SKIP_PLAY_ROOP_MAX_COUNT = 1000;
com_dango_$itimi_scenario_framework_text_Subtitle.CHARACTER_DISPLAY_INTERVAL_COUNT_DEFAULT_VALUE = -1;
com_dango_$itimi_scenario_transition_screen_$change_Fade.DEFAULT_OPACITY_MAX = 100;
com_dango_$itimi_scenario_transition_screen_$change_Fade.DEFAULT_OPACITY_MIN = 0;
com_dango_$itimi_scenario_transition_screen_$change_Fade.DEFAULT_AMOUNT = 10;
haxe_Serializer.USE_CACHE = false;
haxe_Serializer.USE_ENUM_INDEX = false;
haxe_Serializer.BASE64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:";
haxe_Unserializer.DEFAULT_RESOLVER = Type;
haxe_Unserializer.BASE64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789%:";
haxe_ds_ObjectMap.count = 0;
haxe_io_FPHelper.i64tmp = (function($this) {
	var $r;
	var x = new haxe__$Int64__$_$_$Int64(0,0);
	$r = x;
	return $r;
}(this));
haxegame_Main.FPS = 24;
haxegame_game_scenario_Chapter.__meta__ = { fields : { scene1 : { scene : null}, scene2 : { scene : null}}};
haxegame_game_scenario_Scene1.__meta__ = { fields : { apple : { event : null}, orange : { event : null}, banana : { event : null}}};
haxegame_game_scenario_Scene2.__meta__ = { fields : { table : { event : null}, bed : { event : null}}};
haxegame_game_scenario_Items.__meta__ = { fields : { sword : { event : null}, shield : { event : null}}};
haxegame_game_subtitle_Translator.CHARACTER_DISPLAY_INTERVAL = 1;
haxegame_game_subtitle_Translator.SOUND_TIMING = 1;
js_Boot.__toStr = {}.toString;
js_html_compat_Uint8Array.BYTES_PER_ELEMENT = 1;
haxegame_Main.main();
})(typeof console != "undefined" ? console : {log:function(){}}, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);

//# sourceMappingURL=main.js.map