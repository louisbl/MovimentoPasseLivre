package com.pentaped.turbobrazil.systems.graphics.elements;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.core.GameData;
import com.pentaped.turbobrazil.nodes.MainCharNode;
import com.pentaped.turbobrazil.components.Position2D;
import com.pentaped.turbobrazil.components.CustomWaypoint;
import com.pentaped.turbobrazil.components.TargetPlace;
import flash.display.Bitmap;
import openfl.Assets;

class MainCharSys extends ListIteratingSystem<MainCharNode> {

	@inject
	public var data : GameData;

	public function new( ) {
		super( MainCharNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : MainCharNode, delta_time : Float ) : Void {
	}

  function _onNodeAdded( node : MainCharNode ) {
		trace( '_onNodeAdded:$node' );
		node.sprite.sprite.addChild( new Bitmap( Assets.getBitmapData( "assets/hero.png" ) ) );
		node.loops.elements.push( data.main_loops[0] );
		node.entity.add( new TargetPlace( ) );
		trace( '${node.loops.current}' );
	}
}
