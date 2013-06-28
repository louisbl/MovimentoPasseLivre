package com.pentaped.turbobrazil.systems.graphics.renderers;

import flash.display.BitmapData;
import flash.geom.Point;

import ash.tools.ListIteratingSystem;
import ash.core.System;

import com.pentaped.turbobrazil.nodes.BitmapNode;

/**
 * Manage static bitmap
 */
class BitmapSys extends ListIteratingSystem<BitmapNode> {

	var _point : Point;
	var _index : Int;

	public function new( ) {
		super( BitmapNode, _updateNode );
		_point = new Point( );
		_index = 0;
	}

	function _updateNode( node : BitmapNode, delta_time : Float ) : Void {
		var level = Type.enumIndex( planet.environment_level );
		for( bml in node.bmp_list.bmls ) {
			bml.current = level;
			_index = node.bmp_list.z_index.get( bml );
			if( bml.bmd != null && node.anim.bmds[_index] != bml.bmd ) {
				node.anim.offsets.set( bml.bmd, _point );
				node.anim.bmds[_index] = bml.bmd;
				node.anim.dirty = true;
			}
		}
	}

}
