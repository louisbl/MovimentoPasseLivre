package com.pentaped.turbobrazil.components;

class TargetPlace {

	public var targets : Array<Position2D>;
	public var current : Position2D;

	public function new( ) {
		targets = new Array<Position2D>( );
		current = targets[0];
	}

}
