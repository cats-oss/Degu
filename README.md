# UIApplicationDebugKit

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat)](https://developer.apple.com/swift)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

If you want to get all events of an application, you can get events from `UIApplication.sendEvent(_:)`. But, following implementations are needed to get events from it.

```swift
/* MyApplication.swift */

class MyApplication: UIApplication {
    override sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        print(event)
    }
}
```

```swift
/* main.swift */

private let applicationClassName: String = {
    #if DEBUG
        return NSStringFromClass(MyApplication.self)
    #else
        return NSStringFromClass(UIApplication.self)
    #endif
}()

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    applicationClassName,
    NSStringFromClass(AppDelegate.self)
)
```

```swift
/* AppDelegate.swift */

// @UIApplicationMain <- comment out
class AppDelegate: UIResponder, UIApplicationDelegate {
    ...
}
```

`UIApplicationDebugKit` makes them easy!!

## Usage

This is an example. There are only 2 implementations what you have to.

- set a delegate to `application.proxy.delegate`
- implement `UIApplicationProxyDelegate`

```swift
import UIApplicationDebugKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    ...

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        #if DEBUG
        application.proxy.delegate = self
        #endif

        ...

        return true
    }

    ...
}

extension AppDelegate: UIApplicationProxyDelegate {
    func applicationProxy(_ proxy: UIApplicationProxy, didSendEvent event: UIEvent) {
        print(event)
    }
}
```

## Requirements

- Xcode 9.1
- Swift 4

## License

UIApplicationDebugKit is available under the MIT license. See the LICENSE file for more info.
