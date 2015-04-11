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
	private static String useTestMode = "::ENV_AdBuddizTestMode::"; 
	private static String logLevel = "::ENV_AdBuddizLogLevel::";
	
	private static HaxeObject callback;
	
	public static void setCallbackListener(HaxeObject haxe_callback) {
		callback = haxe_callback;
	}
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		if (logLevel == "Silent") AdBuddiz.setLogLevel(AdBuddizLogLevel.Silent);
		else if (logLevel == "Info") AdBuddiz.setLogLevel(AdBuddizLogLevel.Info);
		else if (logLevel == "Error") AdBuddiz.setLogLevel(AdBuddizLogLevel.Error);

		AdBuddiz.setPublisherKey(publisherKey); 
		if(useTestMode != "null" && useTestMode != "false") AdBuddiz.setTestModeActive();                 
		AdBuddiz.cacheAds(Extension.mainActivity);
		
		AdBuddiz.setDelegate(new AdBuddizDelegate() {
			@Override
			public void didCacheAd() {
				callback.call1("call", "cached");
			}
			@Override
			public void didShowAd() {
				callback.call1("call", "shown");
			}
			@Override
			public void didFailToShowAd(AdBuddizError error) {
				callback.call2("call", "failed", error.name());
			}
			@Override
			public void didClick() {
				callback.call1("call", "clicked");
			}
			@Override
			public void didHideAd() { 
				callback.call1("call", "hidden");
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
	
	public static String getType() {
		return AdBuddiz.getType();
	}
	
	public static String getNetworkVersion() {
		return AdBuddiz.getVersion();
	}

}