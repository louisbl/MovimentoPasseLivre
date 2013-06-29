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

	public function createGame( ) {
		_createMap( );
		_createMainChar( );
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

		map.addChild( new Bitmap( Assets.getBitmapData( "assets/export_ville.png" ) ) );
		container.addChild( map );
	}

	function _createMainChar( ) {
		var sp = new Sprite( );
		sp.addChild( new Bitmap( Assets.getBitmapData( "assets/epic_pentaped.png" ) ) );
		var spa = new SpriteAnimation( );
		spa.sprite = sp;
		var main_char = new Entity( "main_char" )
			.add( new Position2D( ) )
			.add( new Scale2D( ) )
			.add( spa )
			.add( new MainChar( ) )
			.add( new TargetPlace( ) )
			.add( new GPUAnimation( ) );

		engine.addEntity( main_char );
	}

}
