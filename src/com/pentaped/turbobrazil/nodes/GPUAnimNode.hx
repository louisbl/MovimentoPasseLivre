package com.pentaped.turbobrazil.nodes;

import ash.core.Node;
import com.pentaped.turbobrazil.components.Position2D;
import com.pentaped.turbobrazil.components.Scale2D;
import com.pentaped.turbobrazil.components.GPUAnimation;

class GPUAnimNode extends Node<GPUAnimNode> {

	public var anim    	: GPUAnimation;
	public var position	: Position2D;
	public var scale   	: Scale2D;

}
