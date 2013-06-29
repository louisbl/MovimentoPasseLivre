package com.pentaped.turbobrazil.components;

class LoopList<T> {

	public var elements : Array<T>;
	public var index : Int;
	public var current( get, null ) : T;

	public function new( ) {
		elements = new Array<T>( );
		index = 0;
	}

	function get_current( ) : T {
		return elements[index];
	}

}
