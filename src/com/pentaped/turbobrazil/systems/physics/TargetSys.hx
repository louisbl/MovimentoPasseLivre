package com.pentaped.turbobrazil.systems.physics;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.nodes.TargetNode;
import com.pentaped.turbobrazil.components.Position2D;
import com.pentaped.turbobrazil.components.CustomWaypoint;

class TargetSys extends ListIteratingSystem<TargetNode> {

	@inject( 'map_waypoints' )
	public var waypoints : DA<CustomWaypoint>;

	public function new( ) {
		super( TargetNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : TargetNode, delta_time : Float ) : Void {
		if( node.place.arrived ) {
			node.place.index++;
			if( node.place.current == null ) {
				node.place.index = 0;
			}
		}
	}

  function _onNodeAdded( node : TargetNode ) {
		trace( '_onNodeAdded:$node' );
		// TODO: Add specific targets
		var wp : CustomWaypoint;
		for( p in node.loops.current ) {
			wp = waypoints.get( p );
			trace( 'wp:$wp' );
			var pos = new Position2D( );
			pos.x = Std.int( wp.x );
			pos.y = Std.int( wp.y );
			node.place.elements.push( pos );
		}
		// node.place.index = 0;
	}
}
