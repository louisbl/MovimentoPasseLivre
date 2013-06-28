import flash.display.Sprite;

import com.pentaped.turbobrazil.core.TurboBrazil;

class Main extends Sprite {

	public function new () {
		super ();

		var turbo 	: TurboBrazil;
		var gamesp	: Sprite;

		gamesp	= new Sprite( );
		turbo 	= new TurboBrazil( gamesp );

		addChild( gamesp );

		#if ( cpp && debug )
			addChild( new Stats() );
			turbo.onStarted.addOnce( function( ) {
				trace( 'started !' );
				cpp.vm.Profiler.start("log.txt");

				#if debugger
					new hxcpp.DebugStdio(false);
				#end

			} );
		#end

		turbo.start( );

	}

}
