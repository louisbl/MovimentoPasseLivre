package com.pentaped.turbobrazil.core;

import flash.geom.Point;

class GameData {

	public var arcs        	( default, null ) : Array<Int>;
	public var map_id      	( default, null ) : Array<{x:Int,y:Int,lenght:Int}>;
	public var main_loops  	( default, null ) : Array<Array<Int>>;
	public var people_loops	( default, null ) : Array<Array<Int>>;

}
