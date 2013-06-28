package com.pentaped.turbobrazil.components;

class Animation implements Poolable {

	public var behaviors 	:	Map<String,String>;
	public var anim_index	: Int;

	public function new( ) {
		anim_index	= -1;
		behaviors 	= new Map<String,String>( );
	}

	public function reset( ) : Void {
		anim_index	= -1;
		for( key in behaviors.keys( ) ) {
			behaviors.remove( key );
		}
	}

}
