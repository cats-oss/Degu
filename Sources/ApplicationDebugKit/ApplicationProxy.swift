//
//  ApplicationProxy.swift
//  ApplicationDebugKit
//
//  Created by marty-suzuki on 2018/04/18.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

#if os(iOS) || os(tvOS)
    import UIKit
    public typealias Application = UIApplication
    public typealias Event = UIEvent
    public typealias ViewController = UIViewController
#elseif os(macOS)
    import AppKit
    public typealias Application = NSApplication
    public typealias Event = NSEvent
    public typealias ViewController = NSViewController
#endif


// MARK: - ApplicationProxy

public final class ApplicationProxy {
    public static let shared = ApplicationProxy()

    /// Base UIApplication.
    public private(set) weak var application: Application?

    /// default nil. weak reference
    public weak var delegate: ApplicationProxyDelegate?

    private init() {
        /// this initializer is not called until ApplicationProxy.shared is called.
        _ = _onceSwizzlingForApplication
        _ = _onceSwizzlingForViewController
    }
}

extension ApplicationProxy {
    func didSendEvent(_ event: Event) {
        delegate?.applicationProxy(self, didSendEvent: event)
    }

    #if os(iOS) || os(tvOS)
        func didSendAction(_ action: Selector, to target: Any?, from sender: Any?, for event: Event?) {
            delegate?.applicationProxy(self, didSendAction: action, to: target, from: sender, for: event)
        }
    #elseif os(macOS)
        func didSendAction(_ action: Selector, to target: Any?, from sender: Any?) {
            delegate?.applicationProxy(self, didSendAction: action, to: target, from: sender)
        }
    #endif
}

extension ApplicationProxy {
    func didCallLifeCycle(_ lifeCycle: ViewControllerLifeCycle, of viewController: ViewController) {
        delegate?.applicationProxy(self, didCallLifeCycle: lifeCycle, ofViewController: viewController)
    }
}
