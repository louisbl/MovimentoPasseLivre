package com.pentaped.turbobrazil.systems.physics;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.DA;
import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Graph;

import com.pentaped.turbobrazil.nodes.TargetNode;
import com.pentaped.turbobrazil.components.Position2D;
import com.pentaped.turbobrazil.components.CustomWaypoint;

class TargetSys extends ListIteratingSystem<TargetNode> {

	@inject( 'map_waypoints' )
	public var waypoints : DA<CustomWaypoint>;

	@inject( 'map_astar' )
	public var astar : AStar;

	@inject( 'map_graph' )
	public var graph : Graph<AStarWaypoint>;

	public function new( ) {
		super( TargetNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : TargetNode, delta_time : Float ) : Void {
		if( node.place.arrived ) {
			if( node.place.reset ) {
				_fillWaypoints( node );
				node.place.reset = false;
			}
			node.place.index++;
			if( node.place.current == null ) {
				node.place.index = 0;
			}
		}
	}

  function _onNodeAdded( node : TargetNode ) {
		trace( '_onNodeAdded:$node' );
		// TODO: Add specific targets
		// _fillWaypoints( node );
	}

	function _fillWaypoints( node : TargetNode ) {
		var wp = waypoints.get( node.loops.current[0] );
		var path = _getPath( node.place.current, wp );

		node.place.elements = [];
		trace( '${node.loops.index}');
		trace( '${node.loops.elements}');

		for( wp in path ) {
			node.place.elements.push( wp );
		}

		for( p in node.loops.current ) {
			wp = waypoints.get( p );
			// trace( 'wp:$wp' );
			// var pos = new Position2D( );
			// pos.x = Std.int( wp.x );
			// pos.y = Std.int( wp.y );
			node.place.elements.push( wp );
		}
	}

	function _getPath( source : AStarWaypoint, target : AStarWaypoint ) : DA<AStarWaypoint> {
		var path = new DA<AStarWaypoint>();
		if( source == null || target == null ) {
			return path;
		}
		var pathExists = astar.find(graph, source, target, path);
		trace('path exists: ' + pathExists);
		if (pathExists) trace('waypoints : ' + path);

		return path;

	}

}
