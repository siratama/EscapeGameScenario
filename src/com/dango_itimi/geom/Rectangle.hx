package com.dango_itimi.geom;

import com.dango_itimi.geom.Rectangle;
using com.dango_itimi.geom.Rectangle.RectangleUtil;

typedef Rectangle =
{
	public var height:Float;
	public var width:Float;
	public var x:Float;
	public var y:Float;
}

class RectangleUtil
{
	public static function getRight(rectangle:Rectangle):Float
	{
		return rectangle.x + rectangle.width;
	}
	public static function getBottom(rectangle:Rectangle):Float
	{
		return rectangle.y + rectangle.height;
	}
	public static function create(x:Float, y:Float, width:Float, height:Float):Rectangle
	{
		return {x:x, y:y, width:width, height:height};
	}
	public static function clone(rectangle:Rectangle):Rectangle
	{
		return create(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
	}
	public static function setPosition(rectangle:Rectangle, x:Float, y:Float)
	{
		rectangle.x = x;
		rectangle.y = y;
	}
	public static function setPoint(rectangle:Rectangle, point:{x:Float, y:Float})
	{
		setPosition(rectangle, point.x, point.y);
	}
	public static function addPosition(rectangle:Rectangle, addedX:Float, addedY:Float)
	{
		rectangle.x += addedX;
		rectangle.y += addedY;
	}
	public static function addPoint(rectangle:Rectangle, point:{x:Float, y:Float})
	{
		addPosition(rectangle, point.x, point.y);
	}
	public static function hitTestPosition(rectangle:Rectangle, x:Float, y:Float):Bool
	{
		return (rectangle.x <= x && rectangle.y <= y && rectangle.getRight() >= x && rectangle.getBottom() >= y);
	}
	public static function hitTestPoint(rectangle:Rectangle, point:{x:Float, y:Float}):Bool
	{
		return rectangle.hitTestPosition(point.x, point.y);
	}
	public static function hitTestObject(rectangle1:Rectangle, rectangle2:Rectangle):Bool
	{
		if(rectangle1.x > rectangle2.getRight()) return false;
		if(rectangle1.getRight() < rectangle2.x) return false;
		if(rectangle1.y > rectangle2.getBottom()) return false;
		if(rectangle1.getBottom() < rectangle2.y) return false;

		return true;
	}
}
