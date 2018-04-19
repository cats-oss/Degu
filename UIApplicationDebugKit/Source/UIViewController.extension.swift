//
//  UIViewController.extension.swift
//  UIApplicationDebugKit
//
//  Created by marty-suzuki on 2018/04/19.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import UIKit

/// Represent ViewController life cycles.
public enum ViewControllerLifeCycle {
    case viewDidLoad
    case viewWillAppear
    case viewDidAppear
    case viewWillDisappear
    case viewDidDisappear
    case viewWillLayoutSubviews
    case viewDidLayoutSubviews
}

let _onceSwizzlingForUIViewController: () = {
    swizzle(UIViewController.self,
            from: #selector(UIViewController.viewDidLoad),
            to: #selector(UIViewController._swizzled_viewDidLoad))

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
}()

extension UIViewController {
    private var _applicationProxy: UIApplicationProxy {
        return UIApplication.shared.proxy
    }

    @objc fileprivate func _swizzled_viewDidLoad() {
        _swizzled_viewDidLoad()
        _applicationProxy.delegate?.applicationProxy(_applicationProxy,
                                                     didCallLifeCycle: .viewDidLoad,
                                                     ofViewController: self)
    }

    @objc fileprivate func _swizzled_viewWillAppear(_ animated: Bool) {
        _swizzled_viewWillAppear(animated)
        _applicationProxy.delegate?.applicationProxy(_applicationProxy,
                                                     didCallLifeCycle: .viewWillAppear,
                                                     ofViewController: self)
    }

    @objc fileprivate func _swizzled_viewDidAppear(_ animated: Bool) {
        _swizzled_viewDidAppear(animated)
        _applicationProxy.delegate?.applicationProxy(_applicationProxy,
                                                     didCallLifeCycle: .viewDidAppear,
                                                     ofViewController: self)
    }

    @objc fileprivate func _swizzled_viewWillDisappear(_ animated: Bool) {
        _swizzled_viewWillDisappear(animated)
        _applicationProxy.delegate?.applicationProxy(_applicationProxy,
                                                     didCallLifeCycle: .viewWillDisappear,
                                                     ofViewController: self)
    }

    @objc fileprivate func _swizzled_viewDidDisappear(_ animated: Bool) {
        _swizzled_viewDidDisappear(animated)
        _applicationProxy.delegate?.applicationProxy(_applicationProxy,
                                                     didCallLifeCycle: .viewDidDisappear,
                                                     ofViewController: self)
    }

    @objc fileprivate func _swizzled_viewWillLayoutSubviews() {
        _swizzled_viewWillLayoutSubviews()
        _applicationProxy.delegate?.applicationProxy(_applicationProxy,
                                                     didCallLifeCycle: .viewWillLayoutSubviews,
                                                     ofViewController: self)
    }

    @objc fileprivate func _swizzled_viewDidLayoutSubviews() {
        _swizzled_viewDidLayoutSubviews()
        _applicationProxy.delegate?.applicationProxy(_applicationProxy,
                                                     didCallLifeCycle: .viewDidLayoutSubviews,
                                                     ofViewController: self)
    }
}
