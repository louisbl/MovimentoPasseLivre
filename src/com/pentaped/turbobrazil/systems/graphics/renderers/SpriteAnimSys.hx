package com.pentaped.turbobrazil.systems.graphics.renderers;

import ash.tools.ListIteratingSystem;

import com.pentaped.turbobrazil.nodes.SpriteAnimNode;
import flash.display.Sprite;

class SpriteAnimSys extends ListIteratingSystem<SpriteAnimNode> {

	@inject( 'map_sprite' )
	public var map : Sprite;

	public function new( ) {
		super( SpriteAnimNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : SpriteAnimNode, delta_time : Float ) : Void {
		if( node.anim.sprite != null ) {
			node.anim.sprite.rotation	= node.position.rotation;
			node.anim.sprite.x       	= node.position.x - node.anim.sprite.width / 2;
			node.anim.sprite.y       	= node.position.y - node.anim.sprite.height / 2;
			node.anim.sprite.scaleX  	= node.scale.x;
			node.anim.sprite.scaleY  	= node.scale.y;
		}
	}

	function _onNodeAdded( node : SpriteAnimNode ) : Void {
		map.addChild( node.anim.sprite );
	}


	function _onNodeRemoved( node : SpriteAnimNode ) : Void {
		map.removeChild( node.anim.sprite );
	}

}
