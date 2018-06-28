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

#if os(iOS) || os(tvOS)
    // MARK: - ApplicationProxy.Once

    extension ApplicationProxy {
        /// Do not use this class directly
        public class _Once {
            /// called before `UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:)` once
            ///
            /// - note: If you want to do something before `UIApplicationDelegate.application(_:didFinishLaunchingWithOptions:)`, override this method.
            @objc dynamic open class func beforeDidFinishLaunching() {
                print("Please override `beforeDidFinishLaunching()` of UIApplicationProxy.Once in extension if you want to use.")
            }

            private init() {}
        }

        public class Once: _Once {
            fileprivate static private(set) var _callBeforeDidFinishLaunchingOnce: () = {
                beforeDidFinishLaunching()
            }()
        }
    }

    // MARK: - UIApplication Extension

    extension UIApplication {
        open override var next: UIResponder? {
            _  = ApplicationProxy.Once._callBeforeDidFinishLaunchingOnce
            return super.next
        }
    }
#endif
