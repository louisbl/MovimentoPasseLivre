package com.pentaped.turbobrazil.core;

import openfl.Assets;

import flash.media.Sound;
import flash.display.BitmapData;

import ash.tools.ComponentPool;
import aze.display.SparrowTilesheet;
import aze.display.TileLayer;
import aze.display.TileClip;

import com.pentaped.turbobrazil.components.BitmapList;

class GameAssets {
	var sprites_folder 	( default, null ) : String;
	var main_gpusprites	( default, null ) : Array<SpriteDataGPU>;

	var bitmaps_existing   	: Map<String,BitmapData>;
	var gpusprites_existing	: Map<SpriteDataGPU,SpriteAssetGPU>;

	public function createBitmaps( ) : Void {
		gpusprites_existing	= new Map<SpriteDataGPU,SpriteAssetGPU>( );
		bitmaps_existing   	= new Map<String,BitmapData>( );

		var fields = Reflect.fields( this );
		var prop : Dynamic;
		for ( field in fields ) {
			if( field.indexOf('_bitmaps') != -1 ) {
				trace( 'bitmaps:$field' );
				prop = Reflect.field( this, field );
				_load( prop );
			} else if( field.indexOf('_gpusprites') != -1 ) {
				trace( 'gpusprites:$field' );
				prop = Reflect.field( this, field );
				_parseGPU( prop );
			}
		}
	}


// -------o audio


// -------o


// -------o

	public function getMainCharClip( index : Int = -1, behave : String = "" ) : TileClip {
		var spasset = getMainCharSpriteAssetGPU( index );
		return _getClip( spasset.layer, behave );
	}

	function _getClip( layer : TileLayer, name : String ) : TileClip {
		var clip 	= new TileClip( layer, name );
		clip.loop	= true;
		clip.fps 	= 30;
		layer.addChild( clip );
		return clip;
	}


// -------o

	public function getMainCharSpriteAssetGPU( index : Int = -1 ) : SpriteAssetGPU {
		return _getSpriteAssetGPU( main_gpusprites, index );
	}


// -------o


	function _getRandomBitmapData( bmds : Array<String> ) : BitmapData {
		return bitmaps_existing.get( _arrayRand( bmds ) );
	}

	function _getBitmapList( ) : BitmapList {
		var bmpl	= ComponentPool.get( BitmapList );
		bmpl.reset( );
		return bmpl;
	}


// -------o

	function _getSpriteAssetGPU( array : Array<SpriteDataGPU>, index : Int ) : SpriteAssetGPU {
		var spdata : SpriteDataGPU;
		if( index == -1 ) {
			spdata = _arrayRand( array  );
		} else {
			spdata = array[ index ];
		}
		return gpusprites_existing.get( spdata );
	}


// -------o

	/**
	 * Load all bitmaps from the array.
	 * Store them in a map with their name as a key
	 */
	function _load( bitmaps : Array<String> ) : Void {
		var l : Int = bitmaps.length;
		while( --l > -1 ) {
			var data = bitmaps[l];
			var bmd = Assets.getBitmapData( data );
			bitmaps_existing.set( data, bmd );
		}
	}


// -------o

	/**
	 * Load all sprites from the array, parse the spritesheet
	 * and load the bitmaps in gpu ram
	 */
	function _parseGPU( sprites : Array<SpriteDataGPU> ) : Void {
		var l : Int = sprites.length;
		while( --l > -1 ) {
			var spdata   	= sprites[l];
			var bmd      	= Assets.getBitmapData( spdata.png );
			var tilesheet	= new SparrowTilesheet( bmd, Assets.getText( spdata.config ) );
			var layer    	= new TileLayer( tilesheet );
			// display_list.layers.set( layer, Type.createEnum( TContainer, spdata.container ) );
			var behaviors	= new Map<String,Behavior>( );

			for ( behave in spdata.behaviors ) {
				behaviors.set( behave.type, behave );
			}
			var spasset = {
				layer : layer,
				behaviors : behaviors
			}
			gpusprites_existing.set( spdata, spasset );
		}
	}


// -------o

	function _arrayRand<TElement>( array : Array<TElement> ) : TElement {
		var index = Std.random( array.length );
		return array[ index ];
	}

}

typedef SpriteAssetGPU = {
	var layer    	: TileLayer;
	var behaviors	: Map<String,Behavior>;
}

typedef SpriteDataGPU = {
	var container	: String;
	var png      	: String;
	var config   	: String;
	var behaviors	: Array<Behavior>;
}

typedef Behavior = {
	var name : String;
	var loop : Bool;
	var type : String;
}
