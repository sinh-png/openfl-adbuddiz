package extension.adbuddiz;

#if android
import openfl.utils.JNI;
#elseif ios
//
#end

#if (android || ios)
@:allow(extension.adbuddiz.AdBuddizCallback) 
class AdBuddiz {
	/**
	 * The version of this extension.
	 */
	inline public static var VERSION:String = "0.1.4";
	
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
		#if android
		if (funcShowAd == null) funcShowAd = JNI.createStaticMethod(CLASS_EXT, "showAd", "()V");
		#elseif ios
		//
		#end
		funcShowAd();
	}
	
	/**
	 * Return true if ad is ready to show, otherwise return false.
	 */
	public static function isReadyToShowAd():Bool {
		#if android
		if (funcIsReadyToShowAd == null) funcIsReadyToShowAd = JNI.createStaticMethod(CLASS_EXT, "isReadyToShowAd", "()Z");
		#elseif ios
		//
		#end
		return funcIsReadyToShowAd();
	}
}

class AdBuddizCallback {
	/**
	 * Callback that will be called when successfully show ad.
	 */
	public var didShowAd:Void->Void;
	
	/**
	 * Callback that will be called when ad is being clicked on.
	 */
	public var didClick:Void->Void;
	
	/**
	 * Callback that will be called when hide ad.
	 */
	public var didHideAd:Void->Void;
	
	/**
	 * Callback that will be called when failed to show ad. This callback has one String type argument.
	 */
	public var didFailToShowAd:String->Void;
	
	public function new() {
		#if android
		JNI.createStaticMethod(AdBuddiz.CLASS_EXT, "setCallbackListener", "(Lorg/haxe/lime/HaxeObject;)V")(this);
		#elseif ios
		//
		#end
	}
	
	function call(type:String, error:String) {
		switch(type) {
			case "didShowAd": if (didShowAd != null) didShowAd();
			case "didClick": if (didClick != null) didClick();
			case "didHideAd": if (didHideAd != null) didHideAd();
			case "didFailToShowAd": if (didFailToShowAd != null) didFailToShowAd(error);
		}
	}
}
#end
