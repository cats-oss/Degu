//
//  ApplicationProxyOnceTests.swift
//  TestTests
//
//  Created by marty-suzuki on 2018/04/25.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import XCTest
import ApplicationDebugKit
@testable import Test

extension ApplicationProxy.Once {
    override public class func beforeDidFinishLaunching() {
        ApplicationProxyOnceTests.isCalledBeforeDidFinishLaunchingMethod = true
    }
}

class ApplicationProxyOnceTests: XCTestCase {
    fileprivate static var isCalledBeforeDidFinishLaunchingMethod = false

    func testBeforeDidFinishLaunching() {
        XCTAssertTrue(ApplicationProxyOnceTests.isCalledBeforeDidFinishLaunchingMethod)
    }
}
