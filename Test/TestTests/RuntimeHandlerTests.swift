//
//  RuntimeHandlerTests.swift
//  TestTests
//
//  Created by marty-suzuki on 2018/04/26.
//  Copyright © 2018年 AbemaTV. All rights reserved.
//

import XCTest
import UIApplicationDebugKit
@testable import Test

extension RuntimeHandler {
    override open class func handleLoad() {
        RuntimeHandlerTests.isCalledLoadHandler = true
    }

    override open class func handleInitialize() {
        RuntimeHandlerTests.isCalledInitializeHandler = true
    }
}

class RuntimeHandlerTests: XCTestCase {
    fileprivate static var isCalledLoadHandler = false
    fileprivate static var isCalledInitializeHandler = false

    func testRuntimeHandler() {
        XCTAssertTrue(RuntimeHandlerTests.isCalledLoadHandler)
        XCTAssertTrue(RuntimeHandlerTests.isCalledInitializeHandler)
    }
}
