package com.pentaped.turbobrazil.components;

import flash.display.BitmapData;

class BitmapList implements Poolable {

	public var bmd ( get, null )	: BitmapData;
	public var current          	: Int;
	public var bmds             	: Array<BitmapData>;

	public function new( ) : Void {
		bmds   	= [];
		current	= -1;
	}

	function get_bmd( ) : BitmapData {
		return bmds[ current ];
	}

	public function reset( ) : Void {
		var l = bmds.length;
		while( --l >= -1 ) {
			bmds.pop( );
		}
		current	= -1;
	}

	public function toString( ) : String {
		return '[BitmapList:
		current:$current,
		bmds:$bmds ]';
	}

}
