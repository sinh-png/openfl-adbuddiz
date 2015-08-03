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

Note that the extension currently only work with OpenFL legacy. To enable legacy mode, add the following before `<haxelib name="openfl" />`

```xml
<set name="openfl-legacy" />
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

##### b) Optional - Logs
You can control the AdBuddiz SDK log level by adding the following line in `"project.xml"`
```xml
<setenv name="AdBuddizLogLevel" value="Info" /> <!-- or Error, Silent -->
```

### 4. Show Ad

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

### 5. Example

An example for using OpenFl-AdBuddiz: https://github.com/hazagames/openfl-adbuddiz-example

That's it!
_______________________________________

https://twitter.com/haza418
