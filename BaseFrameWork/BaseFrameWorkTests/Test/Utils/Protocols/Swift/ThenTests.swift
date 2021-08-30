//
//  ThenTests.swift
//  BaseFrameWorkTests
//
//  Created by ZhangYu on 2021/8/30.
//

import XCTest


class User: NSObject {
    var name: String?
    var email: String?
}


class ThenTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

extension ThenTests {

    func testThen_object() {
        let queue = OperationQueue().then {
            $0.name = "awesome"
            $0.maxConcurrentOperationCount = 5
        }
        XCTAssertEqual(queue.name, "awesome")
        XCTAssertEqual(queue.maxConcurrentOperationCount, 5)
    }

    func testThen_value() {
        let user = User().then {
            $0.name = "SwiftyUtils"
            $0.email = "SwiftyUtils@gmail.com"
        }
        XCTAssertEqual(user.name, "SwiftyUtils")
        XCTAssertEqual(user.email, "SwiftyUtils@gmail.com")
        debugPrint("❤️❤️❤️❤️ user name is :\(String(describing: user.name!))")
    }

}
