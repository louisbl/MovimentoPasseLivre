package com.pentaped.turbobrazil.systems.graphics.renderers;

import ash.core.System;
import ash.core.Engine;
import flash.display.Sprite;

import com.pentaped.turbobrazil.datas.DisplayList;

class DisplaySys extends System {

	@inject('container')
	public var main_container : Sprite;
	@inject
	public var display_list : DisplayList;

	public function new( ) {
		super( );
	}

	override public function addToEngine( engine : Engine ) : Void {
		for ( sprite in display_list.containers ) {
			main_container.addChild( sprite );
		}
		var sprite;
		var container;
		for( layer in display_list.layers.keys( ) ) {
			container	= display_list.layers.get( layer );
			sprite   	= display_list.containers.get( container );
			sprite.addChild( layer.view );
		}
	}

	override public function removeFromEngine( engine : Engine ) : Void {
		for ( sprite in display_list.containers ) {
			main_container.removeChild( sprite );
		}
	}

	override public function update( delta_time : Float ) : Void {
		for ( sprite in display_list.containers ) {
			sprite.graphics.clear( );
		}
		for( layer in display_list.layers.keys( ) ) {
			layer.render( );
		}
	}

}
