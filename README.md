### 1. Install 

Use this command 

`haxelib install openfl-adbuddiz`

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
if (AdBuddiz.IsReadyToShowAd()) {
	trace("Ad is ready to show");
}
```

That's it!

