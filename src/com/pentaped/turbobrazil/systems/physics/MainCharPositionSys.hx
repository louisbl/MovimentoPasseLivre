package com.pentaped.turbobrazil.systems.physics;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.Array2;

import com.pentaped.turbobrazil.nodes.MainCharNode;
import motion.Actuate;
import motion.easing.Linear.LinearEaseNone;

class MainCharPositionSys extends ListIteratingSystem<MainCharNode> {

	public function new( ) {
		super( MainCharNode, _updateNode );
	}

	function _updateNode( node : MainCharNode, delta_time : Float ) : Void {
		if( node.place.current != null && node.place.arrived ) {
			node.place.arrived = false;
			Actuate.tween( node.position,	2, { x : node.place.current.x,
			                             			 y : node.place.current.y } )
			.ease( motion.easing.Linear.easeNone )
				.onComplete( _setArrived, [node] );
		}
	}

	function _setArrived( node : MainCharNode ) {
		node.place.arrived = true;
	}
}
