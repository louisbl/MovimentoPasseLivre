package com.pentaped.turbobrazil.nodes;

import ash.core.Node;

import com.pentaped.turbobrazil.components.*;

class BaseNode<T> extends Node<T> {

	public var place 	: TargetPlace;
	public var loops 	: Loops;
	public var sprite	: SpriteAnimation;
	public var gpu   	: GPUAnimation;

}
