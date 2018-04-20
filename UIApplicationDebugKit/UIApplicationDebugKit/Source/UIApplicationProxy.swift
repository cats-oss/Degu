//
//  UIApplicationProxy.swift
//  UIApplicationDebugKit
//
//  Created by marty-suzuki on 2018/04/18.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import UIKit


// MARK: - UIApplicationProxy

public final class UIApplicationProxy {
    static let key = UnsafeRawPointer(UnsafeMutablePointer<UInt8>.allocate(capacity: 1))

    /// Base UIApplication.
    public private(set) weak var application: UIApplication?

    /// default nil. weak reference
    public weak var delegate: UIApplicationProxyDelegate?

    fileprivate init(_ application: UIApplication) {
        _ = _onceSwizzlingForUIApplication
        _ = _onceSwizzlingForUIViewController
        self.application = application
    }
}

extension UIApplicationProxy {
    func didSendEvent(_ event: UIEvent) {
        delegate?.applicationProxy(self, didSendEvent: event)
    }

    func didSendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) {
        delegate?.applicationProxy(self, didSendAction: action, to: target, from: sender, for: event)
    }
}

extension UIApplicationProxy {
    func didCallLifeCycle(_ lifeCycle: ViewControllerLifeCycle, of viewController: UIViewController) {
        delegate?.applicationProxy(self, didCallLifeCycle: lifeCycle, ofViewController: viewController)
    }
}


// MARK: - UIApplicationProxy.Once

extension UIApplicationProxy {
    /// Do not use this class directly
    public class _Once {
        /// called before `UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:)` once
        ///
        /// - note: If you want to do something before `UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:)`, override this method.
        @objc dynamic open class func beforeDidFinishLaunching() {
            print("Please override `beforeDidFinishLaunching()` of UIApplicationProxy.Once in extension if you want to use.")
        }

        fileprivate init() {}
    }

    public class Once: _Once {
        fileprivate static private(set) var _callBeforeDidFinishLaunchingOnce: () = {
            beforeDidFinishLaunching()
        }()
    }
}


// MARK: - UIApplication Extension

extension UIApplication {
    /// An entrance for UIApplicationProxy.
    public var proxy: UIApplicationProxy {
        let object: UIApplicationProxy
        if let _object = objc_getAssociatedObject(self, UIApplicationProxy.key) as? UIApplicationProxy {
            object = _object
        } else {
            object = UIApplicationProxy(self)
            objc_setAssociatedObject(self, UIApplicationProxy.key, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        return object
    }

    open override var next: UIResponder? {
        _  = UIApplicationProxy.Once._callBeforeDidFinishLaunchingOnce
        return super.next
    }
}
