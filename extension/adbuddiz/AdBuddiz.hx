package extension.adbuddiz;

#if android
import openfl.utils.JNI;
#elseif ios
//
#end

#if (android || ios)
@:allow(extension.adbuddiz.AdBuddizCallback)
@:allow(extension.adbuddiz.RewardedVideo)
class AdBuddiz {
	/**
	 * The version of this extension.
	 */
	inline public static var VERSION:String = "0.1.5";
	
	inline static var CLASS_EXT:String = "me/haza/adbuddiz/AdBuddizExtension";
	
	public static var rewardedVideo:RewardedVideo = new RewardedVideo();
	
	static var _funcShowAd:Void->Void = null;
	static var _funcIsReadyToShowAd:Void->Bool = null;
	
	/**
	 * Callbacks for interstitial ad.
	 */
	public static var callback(default, null):AdBuddizCallback = new AdBuddizCallback();
	
	/**
	 * Display interstitial ad.
	 */
	public static function showAd() {
		#if android
		if (_funcShowAd == null) _funcShowAd = JNI.createStaticMethod(CLASS_EXT, "showAd", "()V");
		#elseif ios
		//
		#end
		_funcShowAd();
	}
	
	/**
	 * Check if the interstitial ad is ready to show.
	 */
	public static function isReadyToShowAd():Bool {
		#if android
		if (_funcIsReadyToShowAd == null) _funcIsReadyToShowAd = JNI.createStaticMethod(CLASS_EXT, "isReadyToShowAd", "()Z");
		#elseif ios
		//
		#end
		return _funcIsReadyToShowAd();
	}
}

class RewardedVideo {
	
	/**
	 * Callbacks for rewarded video.
	 */
	public var callback(default, null):RewardedVideoCallback = new RewardedVideoCallback();
	
	
	static var _funcFetch:Void->Void = null;
	static var _funcShow:Void->Void = null;
	static var _funcIsReadyToShow:Void->Bool = null;
	
	public function new() {
		
	}
	
	/**
	 * Fetch a reward video. 
	 * To minimize bandwidth usage, call this only if you plan to display a rewarded video to the user.
	 */
	public function fetch():Void {
		#if android
		if (_funcFetch == null) _funcFetch = JNI.createStaticMethod(AdBuddiz.CLASS_EXT, "fetchRewardedVideo", "()V");
		#elseif ios
		//
		#end
		_funcFetch();
	}
	
	/**
	 * Display the fetched video. 
	 */
	public function show():Void {
		#if android
		if (_funcShow == null) _funcShow = JNI.createStaticMethod(AdBuddiz.CLASS_EXT, "showRewardedVideo", "()V");
		#elseif ios
		//
		#end
		_funcShow();
	}
	
	/**
	 * Check if the rewarded video is ready to show.
	 */
	public static function isReadyToShow():Bool {
		#if android
		if (_funcIsReadyToShow == null) _funcIsReadyToShow = JNI.createStaticMethod(AdBuddiz.CLASS_EXT, "isReadyToShowRewardedVideo", "()Z");
		#elseif ios
		//
		#end
		return _funcIsReadyToShow();
	}
}

class RewardedVideoCallback {
	
	public function new() {
		
	}
	
	/**
	 * Callback will be called when user fully watched the video. Give the reward here.
	 */
	public var didComplete:Void->Void;
	
	/**
	 * Callback will be called when a video is ready to be displayed.
	 */
	public var didFetch:Void->Void;
	
	/**
	 * Callback will be called when failed to fetch or show a video.
	 */
	public var didFail:String->Void;
	
	/**
	 * Callback  will be called when an error happened during video playback.
	 */
	public var didNotComplete:Void->Void;
	
}

class AdBuddizCallback {
	/**
	 * Callback will be called when successfully show ad.
	 */
	public var didShowAd:Void->Void;
	
	/**
	 * Callback will be called when ad is being clicked on.
	 */
	public var didClick:Void->Void;
	
	/**
	 * Callback will be called when hide ad.
	 */
	public var didHideAd:Void->Void;
	
	/**
	 * Callback will be called when failed to show ad. This callback has one String type argument.
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
			
			case "rewardVideoDidComplete": 
				if (AdBuddiz.rewardedVideo.callback.didComplete != null) AdBuddiz.rewardedVideo.callback.didComplete();
			case "rewardVideoDidFetch": 
				if (AdBuddiz.rewardedVideo.callback.didFetch != null) AdBuddiz.rewardedVideo.callback.didFetch();
			case "rewardVideoDidFail": 
				if (AdBuddiz.rewardedVideo.callback.didFail != null) AdBuddiz.rewardedVideo.callback.didFail(error);
			case "rewardVideoDidNotComplete": 
				if (AdBuddiz.rewardedVideo.callback.didNotComplete != null) AdBuddiz.rewardedVideo.callback.didNotComplete();
				
		}
	}
}

#end
