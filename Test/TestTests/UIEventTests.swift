//
//  UIEventTests.swift
//  TestTests
//
//  Created by marty-suzuki on 2018/04/20.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import XCTest
import Degu
@testable import Test

class UIEventTests: XCTestCase {
    private class ApplicationProxyDelegateMock: ApplicationProxyDelegate {
        var didSendEvent: ((UIEvent) -> Void)?
        var didSendAction: ((Selector, Any?, Any?, UIEvent?) -> Void)?

        func applicationProxy(_ proxy: ApplicationProxy, didSendEvent event: UIEvent) {
            didSendEvent?(event)
        }

        func applicationProxy(_ proxy: ApplicationProxy, didSendAction action: Selector, to target: Any?, from sender: Any?, for event: UIEvent?) {
            didSendAction?(action, target, sender, event)
        }
    }

    private class UIEventMock: UIEvent {}

    private class DummyObj: NSObject {
        @objc func action() {}
    }

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

    func testSendEvent() {
        let event = UIEventMock()

        let expect = expectation(description: "waiting sendEvent")
        delegate.didSendEvent = { e in
            XCTAssertEqual(e, event)
            expect.fulfill()
        }

        application.sendEvent(event)
        wait(for: [expect], timeout: 0.1)
    }

    func testSendAction() {
        let event = UIEventMock()
        let obj = DummyObj()
        let selector = #selector(obj.action)

        let expect = expectation(description: "waiting sendAction")
        delegate.didSendAction = { action, target, sender, e in
            XCTAssertEqual(action, selector)
            XCTAssertEqual(target as? DummyObj, obj)
            XCTAssertNil(sender)
            XCTAssertEqual(e, event)
            expect.fulfill()
        }

        application.sendAction(selector, to: obj, from: nil, for: event)
        wait(for: [expect], timeout: 0.1)
    }
}
