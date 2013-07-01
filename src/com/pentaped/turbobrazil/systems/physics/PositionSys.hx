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
		if( node.place.stopped ) {
			Actuate.stop( node.position );
			return;
		}
		if( node.place.current != null && node.place.arrived ) {
			node.place.arrived = false;
			var currentAngle = node.position.rotation;
			var angleTo = Math.atan2( node.place.current.y - node.position.y,
			                                    node.place.current.x - node.position.x );
			var diffAngle = Math.atan2(Math.sin(angleTo - currentAngle), Math.cos(angleTo - currentAngle));
			angleTo = node.position.rotation + diffAngle;
			Actuate.tween( node.position, 1, {rotation:angleTo} );
			Actuate.tween( node.position, 3 + Math.random( ) * 3, { x : node.place.current.x,
																				 y : node.place.current.y } )
				.ease( motion.easing.Linear.easeNone )
				.onComplete( _setArrived, [node] );
		}
	}

	function _onNodeAdded( node : PositionNode ) {
		trace( '_onNodeAdded:$node' );
		if( node.place.current != null && node.place.arrived ) {
			node.position.x = Std.int( node.place.current.x );
			node.position.y = Std.int( node.place.current.y );
			haxe.Timer.delay( function( ){
				node.place.arrived = true;
				}, Std.random( 5000 ));
		}
	}

	function _setArrived( node : PositionNode ) {
		node.place.arrived = true;
	}

}
