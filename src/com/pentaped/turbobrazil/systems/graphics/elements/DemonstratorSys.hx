package com.pentaped.turbobrazil.systems.graphics.elements;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.core.GameData;
import com.pentaped.turbobrazil.nodes.DemonstratorNode;
import com.pentaped.turbobrazil.components.Position2D;
import com.pentaped.turbobrazil.components.CustomWaypoint;

class DemonstratorSys extends ListIteratingSystem<DemonstratorNode> {

	public function new( ) {
		super( DemonstratorNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : DemonstratorNode, delta_time : Float ) : Void {
	}

  function _onNodeAdded( node : DemonstratorNode ) {
		trace( '_onNodeAdded:$node' );
	}
}
