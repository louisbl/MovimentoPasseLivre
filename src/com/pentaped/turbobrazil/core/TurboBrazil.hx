package com.pentaped.turbobrazil.core;

import minject.Injector;

import ash.core.Engine;
import ash.core.System;
import ash.core.Entity;
import ash.tick.FrameTickProvider;
import ash.tick.FixedTickProvider;

import flash.display.Sprite;
import openfl.Assets;

import de.polygonal.ds.Array2;

import me.beltramo.bbq.JsonType;

import com.pentaped.turbobrazil.systems.inputs.*;
import com.pentaped.turbobrazil.systems.physics.*;
import com.pentaped.turbobrazil.systems.graphics.elements.*;
import com.pentaped.turbobrazil.systems.graphics.renderers.*;

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

		_game_assets	= JsonType.create( assets_json );
		var config  	= JsonType.create( config_json );

		var map_id = new Array2<Int>( config.map_width, config.map_height );

		_injector.mapValue( Array2, map_id, 'map_id' );
		_injector.mapValue( Sprite, _container, 'container' );
		_injector.mapValue( Engine, _engine );
		_injector.mapValue( God, _god );
		_injector.mapValue( GameAssets, _game_assets );
		_injector.mapValue( GameConfig, config );


		_injector.injectInto( _god );

	}

	function _load( ) : Void {

	}

	function _prepareSystems( ) : Void {
		_loadSystem( UserInputSys,	0 );

		_loadSystem( MainCharPositionSys,	1 );

		_loadSystem( GPUAnimSys,   	2 );
		_loadSystem( SpriteAnimSys,	3 );
	}

	function _loadSystem( sys_class : Class<System>, prio : Int ) : Void{
		var sys = _injector.instantiate( sys_class );
		_engine.addSystem( sys, prio );
	}

}
