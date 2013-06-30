package com.roxstudio.haxe.ui;

import com.roxstudio.haxe.game.ResKeeper;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.errors.Error;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;

class RoxBitmapLoader {

    public static inline var READY = 0;
    public static inline var LOADING = 1;
    public static inline var OK = 2;
    public static inline var ERROR = 3;

    public var url(default, null): String;
    public var status(default, null): Int = READY;
    public var progress(default, null): Float = 0.0; // 0.0~1.0
    public var bytesTotal(default, null): Float = 0.0;
    public var bitmapData: BitmapData;

    private var loader: URLLoader;
    private var notifyCallback: Void -> Void;

    public function new(url: String) {
        this.url = url;
        if (url.length > 7 && (url.substr(0, 7) == "http://" || url.substr(0, 7) == "https:/")) {
            loader = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
        } else { // asset
            bitmapData = ResKeeper.loadAssetImage(url);
            status = OK;
            progress = 1.0;
        }
    }

    public function load(notifyCallback: Void -> Void) {
        if (status != READY) return;
        this.notifyCallback = notifyCallback;
        status = LOADING;
        try {
            loader.load(new URLRequest(url));
            loader.addEventListener(Event.COMPLETE, onComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onError);
#if !html5
            loader.addEventListener(flash.events.SecurityErrorEvent.SECURITY_ERROR, onError);
#end
            loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
        } catch (e: Error) {
            onError(e);
        }
    }

    private inline function onComplete(e: Dynamic) {
        status = OK;
        var ldr = new Loader();
        ldr.loadBytes(cast(loader.data));
        bitmapData = cast(ldr.content, Bitmap).bitmapData;
        loader = null;
        notifyCallback();
    }

    private inline function onError(e: Dynamic) {
        status = ERROR;
        loader = null;
        notifyCallback();
    }

    private inline function onProgress(e: ProgressEvent) {
        status = LOADING;
        bytesTotal = e.bytesTotal;
        progress = e.bytesLoaded / bytesTotal;
    }

    public function dispose() {
        url = null;
        notifyCallback = null;
        if (bitmapData != null) {
            bitmapData.dispose();
            bitmapData = null;
        }
        loader = null;
    }

}
