package com.pentaped.turbobrazil.components;

class CustomWaypoint extends de.polygonal.ai.pathfinding.AStarWaypoint {

	public var id : Int;

	public function new( id : Int ) {
		super( );
		this.id = id;
	}

}
