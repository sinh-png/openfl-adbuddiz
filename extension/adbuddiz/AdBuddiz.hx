package extension.adbuddiz;
import cpp.Void;

#if android
import openfl.utils.JNI;
#end

#if ios
import flash.Lib;
#end

#if (android || ios)
@:allow(extension.adbuddiz.AdBuddizCallback) 
class AdBuddiz {
	/**
	 * The version of this extension.
	 */
	inline public static var LIB_VERSION:String = "1.0.0";
	
	inline static var CLASS_EXT:String = "me/haza/adbuddiz/AdBuddizExtension";
	
	static var funcShowAd:Void->Void = null;
	static var funcIsReadyToShowAd:Void->Bool = null;
	static var funcGetType:Void->String = null;
	static var funcGetNetworkVersion:Void->String = null;
	
	/**
	 * You can set the callbacks inside this object.
	 */
	public static var callback(default, null):AdBuddizCallback = new AdBuddizCallback();
	
	/**
	 * Show ad.
	 */
	public static function showAd() {
		if(funcShowAd == null) funcShowAd = JNI.createStaticMethod(CLASS_EXT, "showAd", "()V");
		funcShowAd();
	}
	
	/**
	 * Return true if ad is ready to show, otherwise return false.
	 */
	public static function isReadyToShowAd():Bool {
		if(funcIsReadyToShowAd == null) funcIsReadyToShowAd = JNI.createStaticMethod(CLASS_EXT, "isReadyToShowAd", "()Z");
		return funcIsReadyToShowAd();
	}
	
	/**
	 * Get current SDK type.
	 */
	public static function getType():String {
		if(funcGetType == null) funcGetType = JNI.createStaticMethod(CLASS_EXT, "getType", "()Ljava/lang/String;");
		return funcGetType();
	}
	
	/**
	 * Get SDK version of AdBuddiz. If you want the current version of this extension, use LIB_VERSION instead.
	 */
	public static function getNetworkVersion():String {
		if(funcGetNetworkVersion == null) funcGetNetworkVersion = JNI.createStaticMethod(CLASS_EXT, "getNetworkVersion", "()Ljava/lang/String;");
		return funcGetNetworkVersion();
	}

}

class AdBuddizCallback {
	/**
	 * Callback that will be called when ad is sucessfully cached. This callback has no argument.
	 */
	//public var onCached:Dynamic;
	
	/**
	 * Callback that will be called when successfully show ad. This callback has no argument.
	 */
	public var onShown:Dynamic;
	
	/**
	 * Callback that will be called when ad is being clicked on. This callback has no argument.
	 */
	public var onClicked:Dynamic;
	
	/**
	 * Callback that will be called when hide ad. This callback has no argument.
	 */
	public var onHidden:Dynamic;
	
	/**
	 * Callback that will be called when failed to show ad. This callback has one String type argument.
	 */
	public var onFailed:Dynamic;
	
	public function new() {
		JNI.createStaticMethod(AdBuddiz.CLASS_EXT, "setCallbackListener", "(Lorg/haxe/lime/HaxeObject;)V")(this);
	}
	
	function call(CBType:String, Error:String) {
		switch(CBType) {
			//case "cached": if (onCached != null) onCached();
			case "shown": if (onShown != null) onShown();
			case "clicked": if (onClicked != null) onClicked();
			case "hidden": if (onHidden != null) onHidden();
			case "failed": if (onFailed != null) onFailed(Error);
		}
	}
}
#end