package com.pentaped.turbobrazil.systems.graphics.elements;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.core.GameData;
import com.pentaped.turbobrazil.nodes.DemonstratorNode;
import com.pentaped.turbobrazil.components.*;
import flash.display.Bitmap;
import openfl.Assets;

class DemonstratorSys extends ListIteratingSystem<DemonstratorNode> {

	@inject
	public var data : GameData;

	public function new( ) {
		super( DemonstratorNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : DemonstratorNode, delta_time : Float ) : Void {
	}

  function _onNodeAdded( node : DemonstratorNode ) {
		trace( '_onNodeAdded:$node' );
		node.sprite.sprite.addChild( new Bitmap( Assets.getBitmapData( "assets/foule.png" ) ) );
		node.loops.elements.push( data.foule_loops[ Std.random( data.foule_loops.length ) ] );
		node.entity.add( new TargetPlace( ) );
	}
}
