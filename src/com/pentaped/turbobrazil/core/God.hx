package com.pentaped.turbobrazil.core;

import ash.core.Entity;
import ash.core.Engine;

import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ai.pathfinding.AStar;
import de.polygonal.ds.Graph;
import flash.display.Sprite;
import flash.display.Bitmap;
import openfl.Assets;

import de.polygonal.ds.Array2;
import de.polygonal.ds.DA;

import com.pentaped.turbobrazil.components.*;
import com.pentaped.turbobrazil.core.GameConfig;
import com.pentaped.turbobrazil.core.GameData;

class God {

	@inject
	public var assets : GameAssets;

	@inject
	public var data : GameData;

	@inject
	public var config : GameConfig;

	@inject
	public var engine	: Engine;

	@inject( 'container' )
	public var container : Sprite;

	@inject( 'map_sprite' )
	public var map : Sprite;

	@inject( 'map_graph' )
	public var graph : Graph<AStarWaypoint>;

	@inject( 'map_astar' )
	public var astar : AStar;

	@inject( 'map_waypoints' )
	public var waypoints : DA<CustomWaypoint>;

	public function new( ) {

	}

	public function createPeople( ) {
		var people = new Entity( )
			.add( new People( ) );
			_createBaseEntity( people );
		engine.addEntity( people );
	}

	public function createDemonstrator( ) {
		var demo = new Entity( )
			.add( new Demonstrator( ) );
		_createBaseEntity( demo );
		engine.addEntity( demo );
	}

	public function createGame( ) {
		_createMap( );
		map.addChild( assets.getTileLayer( ).view );
		_createMainChar( );
		_createPeoples( );
		_createDemonstrators( );
	}

	function _createPeoples( ) {
		for (i in 0...6) {
			createPeople( );
		}
	}

	function _createDemonstrators( ) {
		for (i in 0...6) {
			createDemonstrator( );
		}
	}

	function _createMap( ) {
		var i 	= 0;
		var id	= 0;
		while( i < data.map_id.length ) {
			var wp 	= new CustomWaypoint( id++ );
			wp.x   	= data.map_id[ i ].x;
			wp.y   	= data.map_id[ i ].y;
			wp.node	= graph.addNode( graph.createNode( wp ) );

			waypoints.pushBack( wp );
			i++;
		}

		i = 0;
		while( i < data.arcs.length ) {
			var index0 = data.arcs[i++];
			var index1 = data.arcs[i++];
			var source = waypoints.get(index0).node;
			var target = waypoints.get(index1).node;
			graph.addMutualArc(source, target, 1);
		}

		for( i in 0...6 ) {
			var bmp = new Bitmap( Assets.getBitmapData( "assets/0"+(i+1)+".jpg" ) );
			bmp.x = (i%3)*2048;
			if( i >= 3 ) {
				bmp.y = 2048;
			}
			map.addChild( bmp );
		}
		container.addChild( map );
	}

	function _createMainChar( ) {
		var main_char = new Entity( )
			.add( new MainChar( ) );
		_createBaseEntity( main_char );
		engine.addEntity( main_char );
	}

	function _createBaseEntity( entity : Entity ) {
		var sp = new Sprite( );
		var spa = new SpriteAnimation( );
		spa.sprite = sp;
		entity.add( new Scale2D( ) )
			.add( spa )
			.add( new Loops( ) )
			.add( new GPUAnimation( ) );
	}

}
