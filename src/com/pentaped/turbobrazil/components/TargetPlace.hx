package com.pentaped.turbobrazil.components;

import haxe.ds.GenericStack;
import de.polygonal.ai.pathfinding.AStarWaypoint;

class TargetPlace extends LoopList<AStarWaypoint> {

	public var arrived	: Bool;
	public var stopped	: Bool;
	public var reset  	: Bool;

	public function new( ) {
		super( );
		arrived	= true;
		stopped	= false;
		reset  	= true;
	}

	public function toString( ) : String {
		return 'arrived:$arrived, stopped:$stopped, reset:$reset';
	}

}
