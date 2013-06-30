package com.pentaped.turbobrazil.components;

import haxe.ds.GenericStack;
import de.polygonal.ai.pathfinding.AStarWaypoint;

class TargetPlace extends LoopList<AStarWaypoint> {

	public var arrived	: Bool;
	public var reset  	: Bool;

	public function new( ) {
		super( );
		arrived	= true;
		reset  	= true;
	}

}
