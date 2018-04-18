//
//  UIApplicationProxy.swift
//  UIApplicationDebugKit
//
//  Created by marty-suzuki on 2018/04/18.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import UIKit


// MARK: - UIApplicationProxy

private let _onceSwizzlingForUIApplication: () = {
    func swizzle(from originalSelector: Selector, to swizzledSelector: Selector) {
        guard
            let originalMethod = class_getInstanceMethod(UIApplication.self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(UIApplication.self, swizzledSelector)
        else {
            return
        }

        method_exchangeImplementations(originalMethod, swizzledMethod)
    }

    swizzle(from: #selector(UIApplication.sendEvent(_:)),
            to: #selector(UIApplication._swizzled_sendEvent(_:)))
    swizzle(from: #selector(UIApplication.sendAction(_:to:from:for:)),
            to: #selector(UIApplication._swizzled_sendAction(_:to:from:for:)))
}()


// MARK: - UIApplicationProxy

public final class UIApplicationProxy {
    static let key = UnsafeRawPointer(UnsafeMutablePointer<UInt8>.allocate(capacity: 1))

    /// Base UIApplication.
    public private(set) weak var application: UIApplication?

    /// default nil. weak reference
    public weak var delegate: UIApplicationProxyDelegate?

    fileprivate init(_ application: UIApplication) {
        _ = _onceSwizzlingForUIApplication
        self.application = application
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

    @objc fileprivate func _swizzled_sendEvent(_ event: UIEvent) {
        _swizzled_sendEvent(event)
        proxy.delegate?.applicationProxy(proxy, didSendEvent: event)
    }

    @objc fileprivate func _swizzled_sendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) -> Bool {
        let result = _swizzled_sendAction(action, to: target, from: sender, for: event)
        proxy.delegate?.applicationProxy(proxy, didSendAction: action, to: target, from: sender, for: event)
        return result
    }
}
