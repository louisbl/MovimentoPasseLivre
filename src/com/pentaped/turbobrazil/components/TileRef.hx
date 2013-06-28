package com.pentaped.turbobrazil.components;

import ash.core.Entity;

class TileRef {

	public var tiles : Array<Entity>;

	public function new( ) {
		tiles = new Array<Entity>( );
	}

	public function toString( ) : String {
		return '[TileRef: tiles:$tiles ]';
	}

}
