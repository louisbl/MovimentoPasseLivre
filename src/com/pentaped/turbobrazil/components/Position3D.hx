package com.pentaped.turbobrazil.components;

import de.polygonal.ds.Array3;

class Position3D implements Poolable {

	public var coord( get, null )	: Array3Cell;
	public var x                 	: Int;
	public var y                 	: Int;
	public var z                 	: Int;

	var _coord : Array3Cell;

	public function new( ) {
		reset( );
	}

	public function reset( ) : Void {
		x = 0;
		y = 0;
		z = 0;
	}

	function get_coord( ) : Array3Cell {
		if( _coord == null ) {
			_coord = new Array3Cell( );
		}
		_coord.x = x;
		_coord.y = y;
		_coord.z = z;
		return _coord;
	}

	public function toString( ) : String {
		return '[Position3D: x:$x, y:$y, z:$z ]';
	}

}
