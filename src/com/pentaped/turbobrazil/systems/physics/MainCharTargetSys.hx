package com.pentaped.turbobrazil.systems.physics;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.core.GameData;
import com.pentaped.turbobrazil.nodes.MainCharNode;
import com.pentaped.turbobrazil.components.Position2D;
import com.pentaped.turbobrazil.components.CustomWaypoint;

class MainCharTargetSys extends ListIteratingSystem<MainCharNode> {

	@inject
	public var data : GameData;

	@inject( 'map_waypoints' )
	public var waypoints : DA<CustomWaypoint>;

	public function new( ) {
		super( MainCharNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : MainCharNode, delta_time : Float ) : Void {
		if( node.place.arrived ) {
			node.place.index += 1;
			if( node.place.index > node.place.targets.length ) {
				node.place.index = 0;
			}
		}
	}

  function _onNodeAdded( node : MainCharNode ) {
		trace( '_onNodeAdded:$node' );
		// TODO: Add specific targets
		var wp : CustomWaypoint;
		for( p in data.loops[0] ) {
			wp = waypoints.get( p );
			trace( 'wp:$wp' );
			var pos = new Position2D( );
			pos.x = Std.int( wp.x );
			pos.y = Std.int( wp.y );
			node.place.targets.push( pos );
		}
		node.place.index = 0;
	}
}
