//
//  ApplicationProxyDelegate.swift
//  ApplicationDebugKit
//
//  Created by marty-suzuki on 2018/04/18.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

#if os(iOS)
import UIKit

public protocol ApplicationProxyDelegate: class {
    /// Receive parameters of `UIApplication.sendEvent(_:)` when it called.
    ///
    /// - SeeAlso: UIApplication.sendEvent(_:)
    func applicationProxy(_ proxy: ApplicationProxy, didSendEvent event: UIEvent)

    /// Receive parameters of `UIApplication.sendAction(_:to:from:for:)` when it called.
    ///
    /// - SeeAlso: UIApplication.sendAction(_:to:from:for:)
    func applicationProxy(_ proxy: ApplicationProxy, didSendAction action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?)

    /// Receive viewController when its life cycle called.
    func applicationProxy(_ proxy: ApplicationProxy, didCallLifeCycle lifeCycle: ViewControllerLifeCycle, ofViewController viewController: UIViewController)
}

/// Default implementations to make them Optional.
extension ApplicationProxyDelegate {
    public func applicationProxy(_ proxy: ApplicationProxy, didSendEvent event: UIEvent) {}
    public func applicationProxy(_ proxy: ApplicationProxy, didSendAction action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) {}
    public func applicationProxy(_ proxy: ApplicationProxy, didCallLifeCycle lifeCycle: ViewControllerLifeCycle, ofViewController viewController: UIViewController) {}
}
#endif
