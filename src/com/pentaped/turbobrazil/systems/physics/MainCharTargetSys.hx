package com.pentaped.turbobrazil.systems.physics;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.Array2;

import com.pentaped.turbobrazil.nodes.MainCharNode;

class MainCharTargetSys extends ListIteratingSystem<MainCharNode> {

	public function new( ) {
		super( MainCharNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : MainCharNode, delta_time : Float ) : Void {
		if( node.place.current != null ) {
			node.position.x = node.place.current.x;
			node.position.y = node.place.current.y;
		}
	}

	function _onNodeAdded( node : MainCharNode ) {
		// TODO: Add specific targets
		node.place.current = node.place.targets[0];
	}
}
