//
//  UIViewController.extension.swift
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

/// Represent ViewController life cycles.
public enum ViewControllerLifeCycle {
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear

    #if os(iOS) || os(tvOS)
        case viewWillLayoutSubviews
        case viewDidLayoutSubviews
    #elseif os(macOS)
        case viewWillLayout
        case viewDidLayout
    #endif
}

let _onceSwizzlingForViewController: () = {
    swizzle(DeguViewController.self,
            from: #selector(DeguViewController.viewDidLoad),
            to: #selector(DeguViewController._swizzled_viewDidLoad))

    #if os(iOS) || os(tvOS)
        swizzle(UIViewController.self,
                from: #selector(UIViewController.viewWillAppear(_:)),
                to: #selector(UIViewController._swizzled_viewWillAppear(_:)))

        swizzle(UIViewController.self,
                from: #selector(UIViewController.viewDidAppear(_:)),
                to: #selector(UIViewController._swizzled_viewDidAppear(_:)))

        swizzle(UIViewController.self,
                from: #selector(UIViewController.viewWillDisappear(_:)),
                to: #selector(UIViewController._swizzled_viewWillDisappear(_:)))

        swizzle(UIViewController.self,
                from: #selector(UIViewController.viewDidDisappear(_:)),
                to: #selector(UIViewController._swizzled_viewDidDisappear(_:)))

        swizzle(UIViewController.self,
                from: #selector(UIViewController.viewWillLayoutSubviews),
                to: #selector(UIViewController._swizzled_viewWillLayoutSubviews))

        swizzle(UIViewController.self,
                from: #selector(UIViewController.viewDidLayoutSubviews),
                to: #selector(UIViewController._swizzled_viewDidLayoutSubviews))
    #elseif os(macOS)
        swizzle(NSViewController.self,
                from: #selector(NSViewController.viewWillAppear),
                to: #selector(NSViewController._swizzled_viewWillAppear))

        swizzle(NSViewController.self,
                from: #selector(NSViewController.viewDidAppear),
                to: #selector(NSViewController._swizzled_viewDidAppear))

        swizzle(NSViewController.self,
                from: #selector(NSViewController.viewWillDisappear),
                to: #selector(NSViewController._swizzled_viewWillDisappear))

        swizzle(NSViewController.self,
                from: #selector(NSViewController.viewDidDisappear),
                to: #selector(NSViewController._swizzled_viewDidDisappear))

        swizzle(NSViewController.self,
                from: #selector(NSViewController.viewWillLayout),
                to: #selector(NSViewController._swizzled_viewWillLayout))

        swizzle(NSViewController.self,
                from: #selector(NSViewController.viewDidLayout),
                to: #selector(NSViewController._swizzled_viewDidLayout))
    #endif
}()

extension DeguViewController {
    private var _applicationProxy: ApplicationProxy {
        return .shared
    }

    @objc fileprivate func _swizzled_viewDidLoad() {
        _swizzled_viewDidLoad()
        _applicationProxy.didCallLifeCycle(.viewDidLoad, of: self)
    }
}

#if os(iOS) || os(tvOS)
    extension UIViewController {
        @objc fileprivate func _swizzled_viewWillAppear(_ animated: Bool) {
            _swizzled_viewWillAppear(animated)
            _applicationProxy.didCallLifeCycle(.viewWillAppear, of: self)
        }

        @objc fileprivate func _swizzled_viewDidAppear(_ animated: Bool) {
            _swizzled_viewDidAppear(animated)
            _applicationProxy.didCallLifeCycle(.viewDidAppear, of: self)
        }

        @objc fileprivate func _swizzled_viewWillDisappear(_ animated: Bool) {
            _swizzled_viewWillDisappear(animated)
            _applicationProxy.didCallLifeCycle(.viewWillDisappear, of: self)
        }

        @objc fileprivate func _swizzled_viewDidDisappear(_ animated: Bool) {
            _swizzled_viewDidDisappear(animated)
            _applicationProxy.didCallLifeCycle(.viewDidDisappear, of: self)
        }

        @objc fileprivate func _swizzled_viewWillLayoutSubviews() {
            _swizzled_viewWillLayoutSubviews()
            _applicationProxy.didCallLifeCycle(.viewWillLayoutSubviews, of: self)
        }

        @objc fileprivate func _swizzled_viewDidLayoutSubviews() {
            _swizzled_viewDidLayoutSubviews()
            _applicationProxy.didCallLifeCycle(.viewDidLayoutSubviews, of: self)
        }
    }
#elseif os(macOS)
    extension NSViewController {
        @objc fileprivate func _swizzled_viewWillAppear() {
            _swizzled_viewWillAppear()
            _applicationProxy.didCallLifeCycle(.viewWillAppear, of: self)
        }

        @objc fileprivate func _swizzled_viewDidAppear() {
            _swizzled_viewDidAppear()
            _applicationProxy.didCallLifeCycle(.viewDidAppear, of: self)
        }

        @objc fileprivate func _swizzled_viewWillDisappear() {
            _swizzled_viewWillDisappear()
            _applicationProxy.didCallLifeCycle(.viewWillDisappear, of: self)
        }

        @objc fileprivate func _swizzled_viewDidDisappear() {
            _swizzled_viewDidDisappear()
            _applicationProxy.didCallLifeCycle(.viewDidDisappear, of: self)
        }

        @objc fileprivate func _swizzled_viewWillLayout() {
            _swizzled_viewWillLayout()
            _applicationProxy.didCallLifeCycle(.viewWillLayout, of: self)
        }

        @objc fileprivate func _swizzled_viewDidLayout() {
            _swizzled_viewDidLayout()
            _applicationProxy.didCallLifeCycle(.viewDidLayout, of: self)
        }
    }
#endif
