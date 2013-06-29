package com.pentaped.turbobrazil.systems.graphics.elements;

import flash.display.Bitmap;
import openfl.Assets;
import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.core.GameData;
import com.pentaped.turbobrazil.nodes.PeopleNode;
import com.pentaped.turbobrazil.components.Position2D;
import com.pentaped.turbobrazil.components.CustomWaypoint;
import com.pentaped.turbobrazil.components.TargetPlace;

class PeopleSys extends ListIteratingSystem<PeopleNode> {

	@inject
	public var data : GameData;

	public function new( ) {
		super( PeopleNode, _updateNode, _onNodeAdded );
	}

	function _updateNode( node : PeopleNode, delta_time : Float ) : Void {
	}

  function _onNodeAdded( node : PeopleNode ) {
		trace( '_onNodeAdded:${node.sprite}' );
		node.sprite.sprite.addChild( new Bitmap( Assets.getBitmapData( "assets/neutre.png" ) ) );
		node.loops.elements.push( data.people_loops[ Std.random( data.people_loops.length ) ] );
		node.entity.add( new TargetPlace( ) );
	}
}
