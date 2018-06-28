//
//  UIApplication.extension.swift
//  Degu
//
//  Created by marty-suzuki on 2018/04/19.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

let _onceSwizzlingForApplication: () = {
    swizzle(DeguApplication.self,
            from: #selector(DeguApplication.sendEvent(_:)),
            to: #selector(DeguApplication._swizzled_sendEvent(_:)))
    #if os(iOS) || os(tvOS)
        swizzle(UIApplication.self,
                from: #selector(UIApplication.sendAction(_:to:from:for:)),
                to: #selector(UIApplication._swizzled_sendAction(_:to:from:for:)))
    #elseif os(macOS)
        swizzle(NSApplication.self,
                from: #selector(NSApplication.sendAction(_:to:from:)),
                to: #selector(NSApplication._swizzled_sendAction(_:to:from:)))
    #endif
}()

extension DeguApplication {
    private var _applicationProxy: ApplicationProxy {
        return .shared
    }

    @objc fileprivate func _swizzled_sendEvent(_ event: DeguEvent) {
        _swizzled_sendEvent(event)
        _applicationProxy.didSendEvent(event)
    }
}

#if os(iOS) || os(tvOS)
    extension UIApplication {
        @objc fileprivate func _swizzled_sendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) -> Bool {
            let result = _swizzled_sendAction(action, to: target, from: sender, for: event)
            _applicationProxy.didSendAction(action, to: target, from: sender, for: event)
            return result
        }
    }
#elseif os(macOS)
    extension NSApplication {
        @objc fileprivate func _swizzled_sendAction(_ action: Selector, to target: Any?, from sender: Any?) -> Bool {
            let result = _swizzled_sendAction(action, to: target, from: sender)
            _applicationProxy.didSendAction(action, to: target, from: sender)
            return result
        }
    }
#endif
