package com.pentaped.turbobrazil.systems.graphics.elements;

import com.roxstudio.haxe.gesture.RoxGestureAgent;
import com.roxstudio.haxe.gesture.RoxGestureEvent;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;
import openfl.Assets;
import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.core.GameData;
import com.pentaped.turbobrazil.nodes.PeopleNode;
import com.pentaped.turbobrazil.components.*;

class PeopleSys extends ListIteratingSystem<PeopleNode> {

	@inject
	public var data : GameData;

	var _node_sprites : Map<Sprite,PeopleNode>;

	public function new( ) {
		super( PeopleNode, _updateNode, _onNodeAdded, _onNodeRemoved );
		_node_sprites = new Map<Sprite,PeopleNode>( );
	}

	function _updateNode( node : PeopleNode, delta_time : Float ) : Void {
	}

  function _onNodeAdded( node : PeopleNode ) {
		trace( '_onNodeAdded:${node.sprite}' );

		node.sprite.sprite.addChild( new Bitmap( Assets.getBitmapData( "assets/neutre.png" ) ) );

		node.loops.elements = [];
		node.loops.elements.push( data.people_loops[ Std.random( data.people_loops.length ) ] );
		node.place.reset = true;

		node.entity.add( new RoxGestureAgent( node.sprite.sprite ) );

		#if mobile
		node.sprite.sprite.addEventListener( RoxGestureEvent.GESTURE_TAP, _onLongPress );
		#else
		node.sprite.sprite.addEventListener( MouseEvent.CLICK , _onLongPress );
		#end
		_node_sprites.set(node.sprite.sprite,node);
	}

	function _onNodeRemoved( node : PeopleNode ) {
		trace( 'node:$node' );
		node.entity.remove( RoxGestureAgent );
			node.sprite.sprite.removeChildAt( 0 );
		// while( node.sprite.sprite.numChildren > 0 ) {
		// }
		_node_sprites.remove( node.sprite.sprite );
	}

	function _onLongPress( event : Event ) {
		event.target.removeEventListener( RoxGestureEvent.GESTURE_TAP, _onLongPress );
		trace( 'event:$event' );
		var node = _node_sprites.get( event.target );
		node.entity.add( new Demonstrator( ) );
		node.entity.remove( People );
	}

}
