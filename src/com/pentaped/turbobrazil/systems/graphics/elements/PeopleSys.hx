package com.pentaped.turbobrazil.systems.graphics.elements;

import com.roxstudio.haxe.gesture.RoxGestureAgent;
import com.roxstudio.haxe.gesture.RoxGestureEvent;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;
import openfl.Assets;
import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;
import aze.display.TileClip;

import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.core.God;
import com.pentaped.turbobrazil.core.GameData;
import com.pentaped.turbobrazil.core.GameAssets;
import com.pentaped.turbobrazil.nodes.PeopleNode;
import com.pentaped.turbobrazil.components.*;

class PeopleSys extends ListIteratingSystem<PeopleNode> {

	@inject
	public var god : God;

	@inject
	public var data : GameData;

	@inject
	public var assets : GameAssets;

	var _node_sprites : Map<Sprite,PeopleNode>;

	public function new( ) {
		super( PeopleNode, _updateNode, _onNodeAdded, _onNodeRemoved );
		_node_sprites = new Map<Sprite,PeopleNode>( );
	}

	function _updateNode( node : PeopleNode, delta_time : Float ) : Void {
	}

  function _onNodeAdded( node : PeopleNode ) {
		trace( '_onNodeAdded:${node}' );

		var clip = new TileClip( assets.getTileLayer( ), "neutre" );
		clip.loop = true;
		assets.getTileLayer( ).addChild( clip );

		node.gpu.clip = clip;
		node.sprite.sprite.graphics.beginFill( 0, 0 );
		node.sprite.sprite.graphics.drawRect( 0, 0, 100, 100 );
		node.sprite.sprite.graphics.endFill( );

		node.loops.elements = [];
		node.loops.elements.push( data.people_loops[ Std.random( data.people_loops.length ) ] );

		node.entity.add( new TargetPlace( ) );
		node.entity.add( new Position2D( ) );
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
		// node.entity.remove( SpriteAnimation );
		// while( node.sprite.sprite.numChildren > 0 ) {
		// }
		_node_sprites.remove( node.sprite.sprite );
	}

	function _onLongPress( event : Event ) {

		// Assets.getSound( "audio/TransformDemonstrator.wav" ).play( 0, 1 );

		#if mobile
		event.target.removeEventListener( RoxGestureEvent.GESTURE_TAP, _onLongPress );
		#else
		event.target.removeEventListener( MouseEvent.CLICK , _onLongPress );
		#end

		trace( 'event:$event' );
		var node = _node_sprites.get( event.target );
		node.gpu.clip.stop( );
		assets.getTileLayer( ).removeChild( node.gpu.clip );
		node.gpu.clip = null;
		node.entity.add( new Demonstrator( ) );
		node.entity.remove( People );

		god.createPeople( );

	}

}
