### OpenFL-AdBuddiz

AdBuddiz Community extension for OpenFL. Currently only work for Android.

________________________________________________________

#### How To Install

To install, use this command:

`haxelib install openfl-adbuddiz`
________________________________________________________

#### How To Use

Inside **Project.xml** add:

- **`<setenv name="AdBuddizPublisherKey" value="YOUR_PUBLISHER_KEY"/>`** to set your publisher key.

- **`<setenv name="AdBuddizTestModeActive"/>`** to active test mode.

- **`<setenv name="AdBuddizLogLevel" value="Info" />`** in case if you want to set log level (Silent, Info and Error).

Use:

- **`AdBuddiz.showAd()`** to show ad. If the ad failed to show, callback `didFailToShowAd` will be called.

- **`AdBuddiz.isReadyToShowAd()`** to check if ad is ready to be shown.

- **`AdBuddiz.callback`** to access ad callbacks. Eg: `AdBuddiz.callback.didClick = function() trace("Did click on ad");`

- **`AdBuddiz.VERSION`** to get the current version of this extension.

________________________________________________________


https://twitter.com/haza418
	
