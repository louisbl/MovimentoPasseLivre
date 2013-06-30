package com.roxstudio.haxe.ui;

import com.roxstudio.haxe.utils.GbTracer;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.Lib;

class RoxApp {

    public static var screenWidth: Float;
    public static var screenHeight: Float;
    public static var stage: Stage;

    private function new() {
    }

    public static function init() : Void {
        stage = Lib.current.stage;
        stage.align = StageAlign.TOP_LEFT;
        stage.scaleMode = StageScaleMode.NO_SCALE;
        screenWidth = stage.stageWidth;
        screenHeight = stage.stageHeight;
        trace(">>>>stage=("+screenWidth+","+screenHeight+")");
        trace(">>>>curr=("+flash.Lib.current.width+","+flash.Lib.current.height+")");
#if flash
//        haxe.Firebug.redirectTraces();
#elseif cpp
        GbTracer.init("eng/u2g.dat");
#end
    }

}
