# blipperific
A modern iPhone app for Blipfoto, aiming work on all recent devices (iPhone X) and iOS versions (12).

## Contributing

You're more than welcome to submit pull requests for features or issues. You'll need the latest version of XCode and CocoaPods installed.

### Setup

1. Clone the repo.
2. Run `pod install` to download the project dependencies.
3. Double-click "blipperific.xcworkspace" to open the project in XCode
4. Add the following entries to the "Pods/Pods-Blipperific.debug.xcconfig" file:

    ```
    BLIPFOTO_API_URL = https:\/\/api.blipfoto.com\/4\/	
    BLIPFOTO_API_ACCESS_TOKEN  = {YOUR_ACCESS_TOKEN}
    ```
