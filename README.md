# OpenFL-AdBuddiz

AdBuddiz Community extension for OpenFL. Currently only work for Android.

### 1. Install 

Use this command 

`haxelib install openfl-adbuddiz`

If you want to use this repo as the libary source (might get more frequent updates) please use this command

`haxelib git openfl-adbuddiz https://github.com/hazagames/openfl-adbuddiz`

### 2. Import the extension to your project
In `"project.xml"` add the following line
```xml
<haxelib name="openfl-adbuddiz" />
```

### 3. Configure & Initialize 

##### a) Config your publisher key
To set your publisher key, in `"project.xml"` add the following line
```xml
<setenv name="AdBuddizPublisherKey" value="TEST_PUBLISHER_KEY" />
```
Depending on your app, replace `"TEST_PUBLISHER_KEY"` with the right publisher key.

##### b) Optional - Test mode
You can activate test mode by adding the following line in `"project.xml"`
```xml
<setenv name="AdBuddizTestModeActive" />
````

##### c) Optional - Logs
You can control the AdBuddiz SDK log level by adding the following line in `"project.xml"`
```xml
<setenv name="AdBuddizLogLevel" value="Info" /> <!-- or Error, Silent -->
```

### 4. Interstitial Ad

##### a) Show ad

Whenever you want to display an ad, call `AdBuddiz.showAd()`.
We recommend this call be made where there is a natural break in play like between levels for example. 

##### b) Optional - Setting callbacks:

In order to get more information about the SDK behavior, you can set ad callbacks via `AdBuddiz.callback`.

Example:
```haxe
AdBuddiz.callback.didShowAd = function() trace("Did show ad");
AdBuddiz.callback.didHideAd = function() trace("Did hide ad");
AdBuddiz.callback.didClick = function() trace("Did click on ad");
AdBuddiz.callback.didFailToShowAd = function(error:String) trace('Failed to show ad. ERROR: $error');
```

##### c) Optional - Request SDK Status

To know if the SDK will be able to display an ad, you can call `AdBuddiz.isReadyToShowAd()`.
```haxe
if (AdBuddiz.isReadyToShowAd()) {
	trace("Ad is ready to show");
}
```

### 5. Rewarded Video

##### a) Fetch

Before displaying a video, you need to call `AdBuddiz.rewardedVideo.fetch()`. 

*To minimize bandwidth usage, fetch only if you plan to display a rewarded video to the user.*

##### b) Show and request SDK status

Call `AdBuddiz.rewardedVideo.show()` to display a rewarded video. 

To know if the SDK will be able to display a rewarded video, you can call `AdBuddiz.rewardedVideo.isReadyToShow()`. 

```haxe
if (AdBuddiz.rewardedVideo.isReadyToShow()) {
	AdBuddiz.rewardedVideo.show();
}
```

##### c) Give the reward and set callbacks

At the end of the video, you should give a reward to the user. We recommend a reward worth ~15 minutes of gameplay.

`AdBuddiz.rewardedVideo.callback.didComplete` will be called when the user completed the video, set this to your callback to give them the reward. There are also other optional callbacks in `AdBuddiz.rewardedVideo.callback` to help you get more control and information over rewarded video.

Example:
```haxe
AdBuddiz.rewardedVideo.callback.didComplete = function() trace("User fully watched the video, give the reward here.");

// optional
AdBuddiz.rewardedVideo.callback.didFetch = function() trace("A video is ready to be displayed.");
AdBuddiz.rewardedVideo.callback.didFail = function(error:String) trace('SDK was unable to fetch or show a video. ERROR: $error');
AdBuddiz.rewardedVideo.callback.didNotComplete = function() trace("An error happened during video playback.");
```


### 6. Example

An example for using OpenFL-AdBuddiz: https://github.com/hazagames/openfl-adbuddiz-example

_______________________________________

https://twitter.com/haza418
