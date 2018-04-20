//
//  UIApplicationProxyOnceTests.swift
//  TestTests
//
//  Created by marty-suzuki on 2018/04/25.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import XCTest
import UIApplicationDebugKit
@testable import Test

extension UIApplicationProxy.Once {
    override public class func beforeDidFinishLaunching() {
        UIApplicationProxyOnceTests.isCalledBeforeDidFinishLaunchingMethod = true
    }
}

class UIApplicationProxyOnceTests: XCTestCase {
    fileprivate static var isCalledBeforeDidFinishLaunchingMethod = false

    func testBeforeDidFinishLaunching() {
        XCTAssertTrue(UIApplicationProxyOnceTests.isCalledBeforeDidFinishLaunchingMethod)
    }
}
