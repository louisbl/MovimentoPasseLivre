package com.pentaped.turbobrazil.systems.inputs;

import flash.events.MouseEvent;
import flash.ui.Keyboard;
import flash.Lib;
import flash.events.KeyboardEvent;

import de.polygonal.ds.Array3;

import ash.core.NodeList;
import ash.core.System;
import ash.core.Engine;

class UserInputSys extends System {

	public function new( ) {
		super( );
	}

	override public function addToEngine( engine : Engine ) : Void {
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, _onKeyUp );
	}

	override public function removeFromEngine( engine : Engine ) : Void {
		Lib.current.stage.removeEventListener( KeyboardEvent.KEY_UP, _onKeyUp );
	}

	function _onKeyUp( event : KeyboardEvent ) : Void {
		// trace( 'event key code:${event.keyCode}');
		switch ( event.keyCode ) {

			case 27:
				// escape
			case 80:
				// F1
			case 81:
				// F2
			case 82:
				// F3
			case 83:
				// F4
			case 84:
				// F5
			case 85:
				// F6
			case 86:
				// F7
			case 87:
				// F8
			case 88:
				// F9
			case 89:
				// F10

			case Keyboard.Z:
				trace( '----------------------------------------------');
			case Keyboard.NUMBER_1:
			case Keyboard.NUMBER_2:
			case Keyboard.NUMBER_3:
			case Keyboard.NUMBER_4:
			case Keyboard.NUMBER_5:
			case Keyboard.NUMBER_6:
			case Keyboard.NUMBER_7:
			case Keyboard.NUMBER_8:
			case Keyboard.NUMBER_9:

			case Keyboard.L:
			case Keyboard.B:

			case Keyboard.N:
			case Keyboard.ENTER:

			case Keyboard.K:
		}
	}

}
