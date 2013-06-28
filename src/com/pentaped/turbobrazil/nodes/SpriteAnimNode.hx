package com.pentaped.turbobrazil.nodes;

import ash.core.Node;
import com.pentaped.turbobrazil.components.Position2D;
import com.pentaped.turbobrazil.components.Scale2D;
import com.pentaped.turbobrazil.components.SpriteAnimation;

class SpriteAnimNode extends Node<SpriteAnimNode> {

	public var anim    	: SpriteAnimation;
	public var position	: Position2D;
	public var scale   	: Scale2D;

}
