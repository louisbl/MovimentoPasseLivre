package com.pentaped.turbobrazil.systems.graphics.renderers;

import ash.tools.ListIteratingSystem;

import com.pentaped.turbobrazil.nodes.GPUAnimNode;

class GPUAnimSys extends ListIteratingSystem<GPUAnimNode> {

	public function new( ) {
		super( GPUAnimNode, _updateNode );
	}

	function _updateNode( node : GPUAnimNode, delta_time : Float ) : Void {
		if( node.anim.clip != null ) {
			node.anim.clip.rotation	= node.position.rotation;
			node.anim.clip.x       	= node.position.x;
			node.anim.clip.y       	= node.position.y;
			node.anim.clip.scaleX  	= node.scale.x;
			node.anim.clip.scaleY  	= node.scale.y;
		}
	}

}
