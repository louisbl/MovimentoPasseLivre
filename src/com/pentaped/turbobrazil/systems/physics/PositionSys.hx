package com.pentaped.turbobrazil.systems.physics;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.Array2;

import com.pentaped.turbobrazil.nodes.PositionNode;
import motion.Actuate;
import motion.easing.Linear.LinearEaseNone;

class PositionSys extends ListIteratingSystem<PositionNode> {

	public function new( ) {
		super( PositionNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : PositionNode, delta_time : Float ) : Void {
		if( node.place.current != null && node.place.arrived ) {
			node.place.arrived = false;
			Actuate.tween( node.position, 2, { x : node.place.current.x,
																				 y : node.place.current.y } )
				.ease( motion.easing.Linear.easeNone )
				.onComplete( _setArrived, [node] );
		}
	}

	function _onNodeAdded( node : PositionNode ) {
		if( node.place.current != null && node.place.arrived ) {
			node.place.arrived = false;
			Actuate.tween( node.position, 1, { x : node.place.current.x,
																				 y : node.place.current.y } )
				.ease( motion.easing.Linear.easeNone )
				.delay( Std.random( 5 ) )
				.onComplete( _setArrived, [node] );
		}
	}

	function _setArrived( node : PositionNode ) {
		node.place.arrived = true;
	}
}
