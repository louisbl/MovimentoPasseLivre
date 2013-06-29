import flash.display.Sprite;

import com.pentaped.turbobrazil.core.TurboBrazil;
import me.beltramo.bbq.Stats;

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
				new hxcpp.DebugStdio(false);
			#if debugger
			#end
		#end

		turbo.start( );

	}

}
