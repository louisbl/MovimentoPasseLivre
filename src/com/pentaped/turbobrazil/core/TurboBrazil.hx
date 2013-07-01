package com.pentaped.turbobrazil.core;

import de.polygonal.ai.pathfinding.AStar;
import minject.Injector;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;
import ash.tick.FrameTickProvider;
import ash.tick.FixedTickProvider;

import flash.display.Sprite;
import openfl.Assets;

import de.polygonal.ai.pathfinding.AStarWaypoint;
import de.polygonal.ds.Graph;
import de.polygonal.ds.Array2;
import de.polygonal.ds.DA;

import me.beltramo.bbq.JsonType;

import com.pentaped.turbobrazil.systems.inputs.*;
import com.pentaped.turbobrazil.systems.physics.*;
import com.pentaped.turbobrazil.systems.graphics.elements.*;
import com.pentaped.turbobrazil.systems.graphics.renderers.*;
import com.pentaped.turbobrazil.components.*;

class TurboBrazil {

	var _tick       	: FrameTickProvider;
	var _engine     	: Engine;
	var _container  	: Sprite;
	var _injector   	: Injector;
	var _god        	: God;
	var _game_assets	: GameAssets;


	public function new( container : Sprite ) : Void {
		_container = container;
		_init( );
		_load( );
		_prepareSystems( );
		_god.createGame( );
		// Assets.getSound( "audio/LoopInGame.wav" ).play( 0, 99999999 );
	}

	public function start( ) : Void {
		_tick.add( _engine.update );
		_tick.start( );
	}

	public function stop( ) : Void {
		_tick.stop( );
	}

	function _init( ) : Void {
		_god     	= new God( );
		_injector	= new Injector( );
		_engine  	= new Engine( );
		_tick    	= new FrameTickProvider( _container );

		var assets_json	= Assets.getText( "assets/assets.json" );
		var config_json	= Assets.getText( "assets/config.json" );
		var data_json  	= Assets.getText( "assets/data.json" );

		// _game_assets = new GameAssets( );
		// var config = new GameConfig( );
		_game_assets	= JsonType.create( assets_json );
		var config  	= JsonType.create( config_json );
		var data    	= JsonType.create( data_json );

		var map      	= new Sprite( );
		var graph    	= new Graph<AStarWaypoint>( );
		var astar    	= new AStar( graph );
		var waypoints	= new DA<CustomWaypoint>( );
		var session  	= new GameSession( );

		_injector.mapValue( DA, waypoints, 'map_waypoints' );
		_injector.mapValue( AStar, astar, 'map_astar' );
		_injector.mapValue( Graph, graph, 'map_graph' );
		_injector.mapValue( Sprite, _container, 'container' );
		_injector.mapValue( Sprite, map, 'map_sprite' );
		_injector.mapValue( Engine, _engine );
		_injector.mapValue( God, _god );
		_injector.mapValue( GameAssets, _game_assets );
		_injector.mapValue( GameConfig, config );
		_injector.mapValue( GameData, data );
		_injector.mapValue( GameSession, session );

		_injector.injectInto( _god );

	}

	function _load( ) : Void {

	}

	function _prepareSystems( ) : Void {
		_loadSystem( UserInputSys,	0 );

		_loadSystem( MainCharSys,    	1 );
		_loadSystem( PeopleSys,      	1 );
		_loadSystem( DemonstratorSys,	1 );
		_loadSystem( TargetSys,      	2 );
		_loadSystem( PositionSys,    	5 );

		_loadSystem( GPUAnimSys,   	20 );
		_loadSystem( SpriteAnimSys,	30 );
		_loadSystem( MapAnimSys,   	40 );
	}

	function _loadSystem( sys_class : Class<System>, prio : Int ) : Void{
		var sys = _injector.instantiate( sys_class );
		_engine.addSystem( sys, prio );
	}

}
