package extension.adbuddiz;
import cpp.Void;

#if android
import openfl.utils.JNI;
#end

#if (android)
@:allow(extension.adbuddiz.AdBuddizCallback) 
class AdBuddiz {
	/**
	 * The version of this extension.
	 */
	inline public static var VERSION:String = "0.1.1";
	
	inline static var CLASS_EXT:String = "me/haza/adbuddiz/AdBuddizExtension";
	
	static var funcShowAd:Void->Void = null;
	static var funcIsReadyToShowAd:Void->Bool = null;
	
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
}

class AdBuddizCallback {
	/**
	 * Callback that will be called when ad is sucessfully cached. This callback has no argument.
	 */
	//public var didCacheAd:Dynamic;
	
	/**
	 * Callback that will be called when successfully show ad. This callback has no argument.
	 */
	public var didShowAd:Dynamic;
	
	/**
	 * Callback that will be called when ad is being clicked on. This callback has no argument.
	 */
	public var didClick:Dynamic;
	
	/**
	 * Callback that will be called when hide ad. This callback has no argument.
	 */
	public var didHideAd:Dynamic;
	
	/**
	 * Callback that will be called when failed to show ad. This callback has one String type argument.
	 */
	public var didFailToShowAd:Dynamic;
	
	public function new() {
		JNI.createStaticMethod(AdBuddiz.CLASS_EXT, "setCallbackListener", "(Lorg/haxe/lime/HaxeObject;)V")(this);
	}
	
	function call(type:String, error:String) {
		switch(type) {
			//case "didCacheAd": if (didCacheAd != null) didCacheAd();
			case "didShowAd": if (didShowAd != null) didShowAd();
			case "didClick": if (didClick != null) didClick();
			case "didHideAd": if (didHideAd != null) didHideAd();
			case "didFailToShowAd": if (didFailToShowAd != null) didFailToShowAd(error);
		}
	}
}
#end