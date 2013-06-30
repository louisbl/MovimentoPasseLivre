package com.pentaped.turbobrazil.components;

import haxe.ds.GenericStack;

class TargetPlace extends LoopList<Position2D> {

	public var arrived : Bool;

	public function new( ) {
		super( );
		arrived	= true;
	}

}
