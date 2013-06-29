package com.pentaped.turbobrazil.components;

class TargetPlace {

	public var targets             	: Array<Position2D>;
	public var index               	: Int;
	public var arrived             	: Bool;
	public var current( get, null )	: Position2D;

	public function new( ) {
		targets	= new Array<Position2D>( );
		index  	= -1;
		arrived	= true;
	}

	function get_current( ) : Position2D {
		return targets[ index ];
	}

}
