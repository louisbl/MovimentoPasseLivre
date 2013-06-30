package com.pentaped.turbobrazil.nodes;

import ash.core.Node;
import com.pentaped.turbobrazil.components.*;

class PeopleNode extends Node<PeopleNode> {

	public var place 	: TargetPlace;
	public var loops 	: Loops;
	public var sprite	: SpriteAnimation;
	public var gpu   	: GPUAnimation;

	public var people	: People;

}
