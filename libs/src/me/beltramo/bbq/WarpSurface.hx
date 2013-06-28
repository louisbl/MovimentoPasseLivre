package me.beltramo.bbq;

import openfl.Assets;
import flash.Lib;
import flash.display.Sprite;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.events.Event;

import me.beltramo.bbq.TriDatas;

class WarpSurface extends Sprite {
	var _bmd            	: BitmapData;
	var _buttonTL       	: DragSprite;
	var _buttonTR       	: DragSprite;
	var _buttonBR       	: DragSprite;
	var _buttonBL       	: DragSprite;
	var _buttonContainer	: Sprite;
	var _bitmapContainer	: Sprite;
	var _width          	: Int;
	var _height         	: Int;
	var _data           	: TriDatas;

	public function new( asset : String, ww : Int, hh : Int ) {
		super( );
		_bmd   	= Assets.getBitmapData( asset );
		_width 	= ww;
		_height	= hh;
		_data  	= new TriDatas( );
		_init( );
		run( );
	}

	inline public function getTransformData( ) : TriDatas {
		return _data;
	}

	public function dataToString( ) : String {
		var o;
		o = {
			tl	: _buttonTL.center,
			tr	: _buttonTR.center,
			br	: _buttonBR.center,
			bl	: _buttonBL.center
		}
		var s	= haxe.Serializer.run( o );
		return s;
	}

	public function stringToData( s : String ) : Void {
		if( s == null ){
			return;
		}
		var o;
		o = haxe.Unserializer.run( s );
		_buttonTL.setPosition( o.tl, TL );
		_buttonTR.setPosition( o.tr, TR );
		_buttonBR.setPosition( o.br, BR );
		_buttonBL.setPosition( o.bl, BL );
	}

	public function run( ) : Void {
		PerspectiveImage.drawPlane( _bitmapContainer.graphics,
		                           _bmd,
		                           _buttonTL.center,
		                           _buttonTR.center,
		                           _buttonBR.center,
		                           _buttonBL.center,
		                           _data );
	}

	function _init( ) : Void {
		_createButtons();
		_bitmapContainer = new Sprite( );
		addChild( _bitmapContainer );
		addChild( _buttonContainer );
	}

	function _createButtons( ) : Void {
		_buttonContainer = new Sprite();

		_buttonTL = new DragSprite( );
		_buttonTL.create( "assets/handles/tl.png", 0, 0 );
		_buttonTL.setCenter( TL );
		_buttonContainer.addChild( _buttonTL );

		_buttonTR = new DragSprite( );
		_buttonTR.create( "assets/handles/tr.png", _width, 0 );
		_buttonTR.setCenter( TR );
		_buttonContainer.addChild( _buttonTR );

		_buttonBR = new DragSprite( );
		_buttonBR.create( "assets/handles/br.png", _width, _height - 100 );
		_buttonBR.setCenter( BR );
		_buttonContainer.addChild( _buttonBR );

		_buttonBL = new DragSprite( );
		_buttonBL.create( "assets/handles/bl.png", 0, _height - 100 );
		_buttonBL.setCenter( BL );
		_buttonContainer.addChild( _buttonBL );
	}
}

class DragSprite extends Sprite {
	public var center( get_center, null ) : Point;
	var _center_pos : Pos;

	public function new( ) : Void {
		super();
		center     	= new Point( );
		_center_pos	= TL;
		addEventListener( MouseEvent.MOUSE_DOWN, _onMouseDown );
	}

	public function create( asset : String, xx : Int, yy : Int ) : Void {
		addChild( new Bitmap( Assets.getBitmapData( asset ) ) );
		x = xx;
		y = yy;
	}

	public function setCenter( p : Pos ) : Void {
		_center_pos = p;
		switch ( p ) {
			case TL:
			case TR:
				x -= width;
			case BR:
				x -= width;
				y -= height;
			case BL:
				y -= height;
		}
	}

	function _onMouseDown( event : MouseEvent ) : Void {
		removeEventListener( MouseEvent.MOUSE_DOWN, _onMouseDown );
		Lib.current.stage.addEventListener( MouseEvent.MOUSE_UP, _onMouseUp );
		startDrag();
	}

	function _onMouseUp( event : MouseEvent ) : Void {
		Lib.current.stage.removeEventListener( MouseEvent.MOUSE_UP, _onMouseUp );
		addEventListener( MouseEvent.MOUSE_DOWN, _onMouseDown );
		stopDrag();
	}

	public function setPosition( p : Point, pos : Pos ) : Void {
		x = p.x;
		y = p.y;
		setCenter( pos );
	}

	function get_center( ) : Point {
		center.x = 0;
		center.y = 0;
		switch (_center_pos) {
			case TL:
				center.x = x;
				center.y = y;
			case TR:
				center.x = x + width;
				center.y = y;
			case BR:
				center.x = x + width;
				center.y = y + height;
			case BL:
				center.x = x;
				center.y = y + height;
		}
		return center;
	}
}

enum Pos {
	TL;
	TR;
	BR;
	BL;
}
