package com.pentaped.turbobrazil.systems.graphics.elements;

import ash.core.System;
import ash.core.Engine;
import ash.tools.ListIteratingSystem;

import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.core.GameAssets;
import com.pentaped.turbobrazil.core.GameData;
import com.pentaped.turbobrazil.nodes.DemonstratorNode;
import com.pentaped.turbobrazil.components.*;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import openfl.Assets;
import aze.display.TileClip;


class DemonstratorSys extends ListIteratingSystem<DemonstratorNode> {

	@inject
	public var assets : GameAssets;

	@inject
	public var data : GameData;

	@inject( 'map_waypoints' )
	public var waypoints : DA<CustomWaypoint>;

	public function new( ) {
		super( DemonstratorNode, _updateNode, _onNodeAdded, _onNodeRemoved );
	}
/*
	override public function update( delta_time : Float ) {
		for( node in nodeList ) {
			var otherPlace = node.entity.get( TargetPlace );
			otherPlace.stopped = false;
		}
		super.update( delta_time );
	}
*/
	function _updateNode( node : DemonstratorNode, delta_time : Float ) : Void {
		if( !node.demonstrator.in_demo ){
			for( otherNode in nodeList ) {
				if( otherNode == node || !otherNode.demonstrator.in_demo ) {
					continue;
				}
				if( node.sprite.sprite.hitTestObject( otherNode.sprite.sprite ) ) {
						node.demonstrator.in_demo = true;
				}
			}
		}
		var place : TargetPlace = node.entity.get( TargetPlace );
		// trace( 'place:$place' );
		if( place.arrived && place.current == waypoints.get( node.loops.current[0])) {
			node.demonstrator.in_demo = true;
		}
		if( node.demonstrator.in_demo ){
			place.stopped = true;
		}
	}

  function _onNodeAdded( node : DemonstratorNode ) {
		trace( '_onNodeAdded:$node' );

		var clip = new TileClip( assets.getTileLayer( ), "foule_" );
		clip.loop = true;
		assets.getTileLayer( ).addChild( clip );

		var bmp = new BitmapData( 100, 100, true, 0x000000 );
		node.sprite.sprite.addChild( new Bitmap(bmp) );
		// node.sprite.sprite.addChild( new Bitmap( Assets.getBitmapData( "assets/foule.png" ) ) );

		node.loops.index = 0;
		node.loops.elements = [];
		node.loops.elements.push( [ data.foule_id[6] ] );

		if( !node.entity.has( People ) ) {
			var place = new TargetPlace( );
			place.reset = true;
			var wp = waypoints.get( Std.random( data.map_id.length ) );
			place.elements.push( wp );
			node.entity.add( place );
			node.entity.add( new Position2D(  ) );
		} else {
			node.entity.get( TargetPlace ).reset = true;
		}
		node.gpu.clip = clip;
		trace( '${node.loops.elements}');
	}

	function _onNodeRemoved( node : DemonstratorNode ) {
		while( node.sprite.sprite.numChildren > 0 ) {
			node.sprite.sprite.removeChildAt( 0 );
		}
		node.gpu.clip.stop( );
		assets.getTileLayer( ).removeChild( node.gpu.clip );
		node.gpu.clip = null;
	}

}
