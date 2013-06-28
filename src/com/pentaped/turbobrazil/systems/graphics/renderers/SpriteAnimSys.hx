package com.pentaped.turbobrazil.systems.graphics.renderers;

import ash.tools.ListIteratingSystem;

import com.pentaped.turbobrazil.nodes.SpriteAnimNode;
import flash.display.Sprite;

class SpriteAnimSys extends ListIteratingSystem<SpriteAnimNode> {

	@inject( 'container' )
	public var container : Sprite;

	public function new( ) {
		super( SpriteAnimNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : SpriteAnimNode, delta_time : Float ) : Void {
		if( node.anim.sprite != null ) {
			node.anim.sprite.x     	= node.position.x;
			node.anim.sprite.y     	= node.position.y;
			node.anim.sprite.scaleX	= node.scale.x;
			node.anim.sprite.scaleY	= node.scale.y;
		}
	}

	function _onNodeAdded( node : SpriteAnimNode ) : Void {
		container.addChild( node.anim.sprite );
	}

}
