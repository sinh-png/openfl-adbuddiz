package me.haza.adbuddiz;

import android.os.Bundle;

import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

import com.purplebrain.adbuddiz.sdk.AdBuddiz;
import com.purplebrain.adbuddiz.sdk.AdBuddizDelegate;
import com.purplebrain.adbuddiz.sdk.AdBuddizError;
import com.purplebrain.adbuddiz.sdk.AdBuddizLogLevel;

public class AdBuddizExtension extends Extension {
	
	private static String publisherKey = "::ENV_AdBuddizPublisherKey::"; 
	private static String testModeActive = "::ENV_AdBuddizTestModeActive::";
	private static String logLevel = "::ENV_AdBuddizLogLevel::";
	
	private static HaxeObject callback;
	
	public static void setCallbackListener(HaxeObject haxe_callback) {
		callback = haxe_callback;
	}
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		if (logLevel.equals("Silent")) AdBuddiz.setLogLevel(AdBuddizLogLevel.Silent);
		else if (logLevel.equals("Info")) AdBuddiz.setLogLevel(AdBuddizLogLevel.Info);
		else if (logLevel.equals("Error")) AdBuddiz.setLogLevel(AdBuddizLogLevel.Error);

		AdBuddiz.setPublisherKey(publisherKey); 

		if(testModeActive.equals("null") && testModeActive.equals("false")) {
			AdBuddiz.setTestModeActive();                 
		}
		
		AdBuddiz.cacheAds(Extension.mainActivity);
		
		AdBuddiz.setDelegate(new AdBuddizDelegate() {
			@Override
			public void didCacheAd() {
				
			}
			@Override
			public void didShowAd() {
				callback.call1("call", "didShowAd");
			}
			@Override
			public void didFailToShowAd(AdBuddizError error) {
				callback.call2("call", "didFailToShowAd", error.name());
			}
			@Override
			public void didClick() {
				callback.call1("call", "didClick");
			}
			@Override
			public void didHideAd() { 
				callback.call1("call", "didHideAd");
			}
		});
	}
	
	@Override
	public void onDestroy() {
		super.onDestroy();
		AdBuddiz.onDestroy();
	}
	
	public static void showAd() {
		AdBuddiz.showAd(Extension.mainActivity);
	}
	
	public static boolean isReadyToShowAd() {
		return AdBuddiz.isReadyToShowAd(Extension.mainActivity);
	}
}
