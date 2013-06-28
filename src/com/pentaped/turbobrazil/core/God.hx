package com.pentaped.turbobrazil.core;

import ash.core.Entity;
import ash.core.Engine;
import flash.display.Sprite;
import flash.display.Bitmap;
import openfl.Assets;


import com.pentaped.turbobrazil.components.*;
import com.pentaped.turbobrazil.core.GameConfig;

class God {

	@inject
	public var config : GameConfig;

	@inject
	public var engine	: Engine;

	public function new( ) {

	}

	public function createGame( ) {
		_createMainChar( );
	}

	function _createMainChar( ) {
		var sp = new Sprite( );
		sp.addChild( new Bitmap( Assets.getBitmapData( "assets/epic_pentaped.png" ) ) );
		var spa = new SpriteAnimation( );
		spa.sprite = sp;
		var main_char = new Entity( )
			.add( new Position2D( ) )
			.add( new Scale2D( ) )
			.add( spa )
			.add( new MainChar( ) )
			.add( new TargetPlace( ) )
			.add( new GPUAnimation( ) );

		engine.addEntity( main_char );
	}

}
