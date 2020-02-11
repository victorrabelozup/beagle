[![Build Status](https://app.bitrise.io/app/ba33132ae93f50c8/status.svg?token=ET78G0IwTjRaVguEnzRPhw&branch=master)](https://app.bitrise.io/app/ba33132ae93f50c8)
[![codecov](https://codecov.io/gh/ZupIT/darwin-beagle-ios/branch/master/graph/badge.svg?token=hKpCrqZHxt)](https://codecov.io/gh/ZupIT/darwin-beagle-ios)


Beagle is a cross-platform framework that allows to apply Server-Driven UI natively in iOS, Android and Web.Then, the layouts can be created in a Backend for Frontend middleware.

## Getting started
### Requeriments
 * iOS 10.0+
 * Xcode 10.1+
 * Swift 4.2+
### Installation
#### CocoaPods
[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Beagle into your Xcode project using CocoaPods, specify it in your `Podfile`:
```javascript
pod 'BeagleUI'
```
#### Carthage
[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate Beagle into your Xcode project using Carthage, specify it in your `Cartfile`:
```javascript
github "ZupIT/darwin-beagle-ios"
```
### Configuration
In you `AppDelegate` put this code

```javascript
import UIKit
.....

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    .....
    
    Beagle.dependencies = BeagleDependencies(appName: "myAppName")
    
    .....
}
```

## How it works
The BFF will mediate the APIs that will be consumed and use Beagle to create layouts declaratively, serialize to JSON and send it to the Frontend.
In the Frontend, Beagle will deserialize this JSON into a widget and it will be rendered using the design system to a View.

<img src="./assets/BFF.png"/>

## Resources

* [FAQ](https://docs.google.com/spreadsheets/d/1S3Xnwsnc9GnN6R6wSpSfPsFeoaovrRQ9hbl6CZ6ONZE/edit#gid=0)

* [Detailed Guide](https://zupdocs.gitbook.io/beagle/)

* [Frontend example](https://github.com/ZupIT/beagle-tmdb-ios)

* [BFF example](https://github.com/ZupIT/beagle-tmdb-backend)
