//
//  UIViewControllerTests.swift
//  TestTests
//
//  Created by marty-suzuki on 2018/04/20.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import XCTest
import Degu
@testable import Test

class UIViewControllerTests: XCTestCase {
    private class ApplicationProxyDelegateMock: ApplicationProxyDelegate {
        var didCallLifeCycle: ((ViewControllerLifeCycle, UIViewController) -> Void)?

        func applicationProxy(_ proxy: ApplicationProxy, didCallLifeCycle lifeCycle: ViewControllerLifeCycle, ofViewController viewController: UIViewController) {
            didCallLifeCycle?(lifeCycle, viewController)
        }
    }

    private class UIViewControllerMock: UIViewController {}

    private var application: UIApplication!
    private var proxy: ApplicationProxy!
    private var delegate: ApplicationProxyDelegateMock!
    private var viewController: ViewController!

    override func setUp() {
        super.setUp()

        let app = UIApplication.shared
        let delegate = ApplicationProxyDelegateMock()
        ApplicationProxy.shared.delegate = delegate
        self.application = app
        self.proxy = ApplicationProxy.shared
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
