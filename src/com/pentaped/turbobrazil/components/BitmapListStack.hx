package com.pentaped.turbobrazil.components;

import ash.tools.ComponentPool;

class BitmapListStack implements Poolable {

	public var bmls   	: Array<BitmapList>;
	public var z_index	: Map<BitmapList,Int>;

	public function new ( ) {
		bmls   	= [];
		z_index	= new Map<BitmapList,Int>( );
	}

	public function reset( ) : Void {
		var l = bmls.length;
		while( --l >= -1 ) {
			ComponentPool.dispose( bmls.pop( ) );
		}
		for ( key in z_index.keys( ) ) {
			z_index.remove( key );
		}
	}

}
