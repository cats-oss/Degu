//
//  UIViewControllerTests.swift
//  TestAppTests
//
//  Created by marty-suzuki on 2018/04/19.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import XCTest
import UIApplicationDebugKit
@testable import TestApp

class UIViewControllerTests: XCTestCase {
    private class UIApplicationProxyDelegateMock: UIApplicationProxyDelegate {
        var didCallLifeCycle: ((ViewControllerLifeCycle, UIViewController) -> Void)?

        func applicationProxy(_ proxy: UIApplicationProxy, didCallLifeCycle lifeCycle: ViewControllerLifeCycle, ofViewController viewController: UIViewController) {
            didCallLifeCycle?(lifeCycle, viewController)
        }
    }

    private class UIViewControllerMock: UIViewController {}

    private var application: UIApplication!
    private var proxy: UIApplicationProxy!
    private var delegate: UIApplicationProxyDelegateMock!
    private var viewController: ViewController!

    override func setUp() {
        super.setUp()

        let app = UIApplication.shared
        let delegate = UIApplicationProxyDelegateMock()
        app.proxy.delegate = delegate
        self.application = app
        self.proxy = app.proxy
        self.delegate = delegate
        self.viewController = (app.delegate as! AppDelegate).window!.rootViewController as! ViewController
    }
    
    func testLifeCycle() {
        let testVC = UIViewControllerMock()

        AppearingTest: do {
            let expect = expectation(description: "wait appearing life cycles")

            var lifeCycles: [ViewControllerLifeCycle] = []
            let expectedLifeCycles: [ViewControllerLifeCycle] = [
                .viewDidLoad,
                .viewWillAppear,
                .viewDidAppear
            ]
            delegate.didCallLifeCycle = { lifeCycle, viewController in
                switch (lifeCycle, viewController) {
                case (.viewWillDisappear, is ViewController):
                    return
                case (.viewDidDisappear, is ViewController):
                    return
                case (.viewWillLayoutSubviews, _):
                    return
                case (.viewDidLayoutSubviews, _):
                    return
                default:
                    break
                }

                XCTAssertEqual(testVC, viewController)
                lifeCycles.append(lifeCycle)
                if lifeCycles.count == 3, lifeCycles == expectedLifeCycles {
                    expect.fulfill()
                }
            }

            viewController.present(testVC, animated: true, completion: nil)

            wait(for: [expect], timeout: 5)
        }

        LayoutingTest: do {
            let expect = expectation(description: "wait layouting life cycles")

            var lifeCycles: [ViewControllerLifeCycle] = []
            let expectedLifeCycles: [ViewControllerLifeCycle] = [
                .viewWillLayoutSubviews,
                .viewDidLayoutSubviews
            ]
            delegate.didCallLifeCycle = { lifeCycle, viewController in
                XCTAssertEqual(testVC, viewController)
                lifeCycles.append(lifeCycle)
                if lifeCycles.count == 2, lifeCycles == expectedLifeCycles {
                    expect.fulfill()
                }
            }

            let view = UIView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            testVC.view.addSubview(view)
            testVC.view.addConstraints([.top, .left, .right, .bottom]
                .map {
                    NSLayoutConstraint(item: testVC.view,
                                       attribute: $0,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: $0,
                                       multiplier: 1,
                                       constant: 0)
                }
            )

            wait(for: [expect], timeout: 5)
        }

        DisappearingTest: do {
            let expect = expectation(description: "wait disappearing life cycles")

            var lifeCycles: [ViewControllerLifeCycle] = []
            let expectedLifeCycles: [ViewControllerLifeCycle] = [
                .viewWillDisappear,
                .viewDidDisappear
            ]
            delegate.didCallLifeCycle = { lifeCycle, viewController in
                switch (lifeCycle, viewController) {
                case (.viewWillAppear, is ViewController):
                    return
                case (.viewDidAppear, is ViewController):
                    return
                case (.viewWillLayoutSubviews, _):
                    return
                case (.viewDidLayoutSubviews, _):
                    return
                default:
                    break
                }

                XCTAssertEqual(testVC, viewController)
                lifeCycles.append(lifeCycle)
                if lifeCycles.count == 2, lifeCycles == expectedLifeCycles {
                    expect.fulfill()
                }
            }

            testVC.dismiss(animated: true, completion: nil)

            wait(for: [expect], timeout: 5)
        }
    }
}
