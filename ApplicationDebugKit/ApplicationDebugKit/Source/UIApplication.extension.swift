//
//  UIApplication.extension.swift
//  ApplicationDebugKit
//
//  Created by marty-suzuki on 2018/04/19.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import UIKit


let _onceSwizzlingForUIApplication: () = {
    swizzle(UIApplication.self,
            from: #selector(UIApplication.sendEvent(_:)),
            to: #selector(UIApplication._swizzled_sendEvent(_:)))
    swizzle(UIApplication.self,
            from: #selector(UIApplication.sendAction(_:to:from:for:)),
            to: #selector(UIApplication._swizzled_sendAction(_:to:from:for:)))

}()

extension UIApplication {
    private var _applicationProxy: ApplicationProxy {
        return .shared
    }

    @objc fileprivate func _swizzled_sendEvent(_ event: UIEvent) {
        _swizzled_sendEvent(event)
        _applicationProxy.didSendEvent(event)
    }

    @objc fileprivate func _swizzled_sendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) -> Bool {
        let result = _swizzled_sendAction(action, to: target, from: sender, for: event)
        _applicationProxy.didSendAction(action, to: target, from: sender, for: event)
        return result
    }
}
