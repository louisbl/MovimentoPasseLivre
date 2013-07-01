package com.pentaped.turbobrazil.systems.graphics.renderers;

import ash.core.Entity;
import ash.core.NodeList;
import ash.core.System;
import ash.core.Engine;

import flash.display.Sprite;

import com.pentaped.turbobrazil.core.GameAssets;
import com.pentaped.turbobrazil.components.SpriteAnimation;
import com.pentaped.turbobrazil.nodes.MainCharNode;
import flash.Lib;

class MapAnimSys extends System {

	@inject
	public var assets : GameAssets;

	@inject( 'map_sprite' )
	public var map : Sprite;

	var main_char : NodeList<MainCharNode>;

	var scale = 1;

	public function new( ) {
		super( );
	}

	override public function addToEngine( engine : Engine ) : Void {
		main_char = engine.getNodeList( MainCharNode );
		map.scaleX = map.scaleY = 1/ scale;
	}

	override public function removeFromEngine( engine : Engine ) : Void {
		main_char = null;
	}

	override public function update( delta_time : Float ) : Void {

		assets.getTileLayer().render( );

		var sp = main_char.head.sprite.sprite;
		map.x = -sp.x / scale;
		map.y = -sp.y / scale;

		map.x += Lib.current.stage.stageWidth / 2;
		map.y += Lib.current.stage.stageHeight / 2;
	}
}
