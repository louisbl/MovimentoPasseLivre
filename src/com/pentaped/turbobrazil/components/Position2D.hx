package com.pentaped.turbobrazil.components;

import flash.geom.Point;

import de.polygonal.ds.Array2;

class Position2D implements Poolable {

	public var point( get, null )	: Point;
	public var coord( get, null )	: Array2Cell;
	public var x                 	: Int;
	public var y                 	: Int;
	public var rotation          	: Float;

	var _point : Point;
	var _coord : Array2Cell;

	public function new( ) {
		reset( );
	}

	public function reset( ) : Void {
		x = 0;
		y = 0;
		rotation = 0;
	}

	function get_point( ) : Point {
		if( _point == null ) {
			_point = new Point( );
		}
		_point.x = x;
		_point.y = y;
		return _point;
	}

	function get_coord( ) : Array2Cell {
		if( _coord == null ) {
			_coord = new Array2Cell( );
		}
		_coord.x = x;
		_coord.y = y;
		return _coord;
	}

	public function toString( ) : String {
		return '[Position2D: x:$x, y:$y ]';
	}
}
