//
//  ApplicationProxyDelegate.swift
//  Degu
//
//  Created by marty-suzuki on 2018/04/18.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import Foundation

public protocol ApplicationProxyDelegate: class {
    /// Receive parameters of `UIApplication.sendEvent(_:)` when it called.
    ///
    /// - SeeAlso: UIApplication.sendEvent(_:)
    func applicationProxy(_ proxy: ApplicationProxy, didSendEvent event: DeguEvent)

    #if os(iOS) || os(tvOS)
        /// Receive parameters of `UIApplication.sendAction(_:to:from:for:)` when it called.
        ///
        /// - SeeAlso: UIApplication.sendAction(_:to:from:for:)
        func applicationProxy(_ proxy: ApplicationProxy, didSendAction action: Selector, to target: Any?, from sender: Any?, for event: DeguEvent?)
    #elseif os(macOS)
        /// Receive parameters of `NSApplication.sendAction(_:to:from)` when it called.
        ///
        /// - SeeAlso: NSApplication.sendAction(_:to:from)
        func applicationProxy(_ proxy: ApplicationProxy, didSendAction action: Selector, to target: Any?, from sender: Any?)
    #endif

    /// Receive viewController when its life cycle called.
    func applicationProxy(_ proxy: ApplicationProxy, didCallLifeCycle lifeCycle: ViewControllerLifeCycle, ofViewController viewController: DeguViewController)
}

/// Default implementations to make them Optional.
extension ApplicationProxyDelegate {
    public func applicationProxy(_ proxy: ApplicationProxy, didSendEvent event: DeguEvent) {}
    #if os(iOS) || os(tvOS)
        public func applicationProxy(_ proxy: ApplicationProxy, didSendAction action: Selector, to target: Any?, from sender: Any?, for event: DeguEvent?) {}
    #elseif os(macOS)
        public func applicationProxy(_ proxy: ApplicationProxy, didSendAction action: Selector, to target: Any?, from sender: Any?) {}
    #endif
    public func applicationProxy(_ proxy: ApplicationProxy, didCallLifeCycle lifeCycle: ViewControllerLifeCycle, ofViewController viewController: DeguViewController) {}
}
