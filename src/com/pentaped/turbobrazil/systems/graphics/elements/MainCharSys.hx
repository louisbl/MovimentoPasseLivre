package com.pentaped.turbobrazil.systems.graphics.elements;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import com.roxstudio.haxe.gesture.RoxGestureAgent;
import com.roxstudio.haxe.gesture.RoxGestureEvent;
import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.core.GameData;
import com.pentaped.turbobrazil.core.GameSession;
import com.pentaped.turbobrazil.nodes.MainCharNode;
import com.pentaped.turbobrazil.components.Position2D;
import com.pentaped.turbobrazil.components.CustomWaypoint;
import com.pentaped.turbobrazil.components.TargetPlace;
import flash.display.Bitmap;
import flash.events.GestureEvent;
import flash.events.MouseEvent;
import flash.events.TouchEvent;
import flash.Lib;
import openfl.Assets;

class MainCharSys extends ListIteratingSystem<MainCharNode> {

	@inject
	public var data : GameData;

	@inject
	public var session : GameSession;

	var _swap : SWAP_DIR;

	public function new( ) {
		super( MainCharNode, _updateNode, _onNodeAdded );
		#if mobile
		var roxges = new RoxGestureAgent( Lib.current.stage, RoxGestureAgent.GESTURE );
		Lib.current.stage.addEventListener( RoxGestureEvent.GESTURE_SWIPE, _onSwipe );
		#end
		_swap = NONE;
	}

	function _updateNode( node : MainCharNode, delta_time : Float ) : Void {
		// if( )
	}

  function _onNodeAdded( node : MainCharNode ) {
		trace( '_onNodeAdded:$node' );
		node.sprite.sprite.addChild( new Bitmap( Assets.getBitmapData( "assets/hero.png" ) ) );
		node.loops.elements.push( data.main_loops[0] );
		node.entity.add( new TargetPlace( ) );
		trace( '${node.loops.current}' );
	}

	function _onSwipe( event : RoxGestureEvent ) {
		trace( 'event:$event' );
		if( event.extra.x > 250 ) {
			_swap = RIGHT;
		} else if( event.extra.x < -250 ) {
			_swap = LEFT;
		} else if( event.extra.y > 250 ) {
			_swap = DOWN;
		} else if( event.extra.x < -250 ) {
			_swap = UP;
		}
	}

}

enum SWAP_DIR {
	NONE;
	UP;
	DOWN;
	RIGHT;
	LEFT;
}
