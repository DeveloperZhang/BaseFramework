//
//  UserDefaultsExtensionTests.swift
//  BaseFrameWorkTests
//
//  Created by ZhangYu on 2021/8/30.
//

import XCTest

class UserDefaultsExtensionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

// MARK: - Subscript

extension UserDefaultsExtensionTests {

    func testSubscript() {
        let defaults = UserDefaults.standard
        let username = "test"
        defaults["userName"] = username
        XCTAssertEqual(defaults["userName"] as? String ?? "", username)
    }
}

// MARK: - Misc

extension UserDefaultsExtensionTests {

    func testHasKey() {
        let key = "aKey"
        let value = "aValue"
        UserDefaults.standard.set(value, forKey: key)
        XCTAssertTrue(UserDefaults.has(key: key))
        XCTAssertFalse(UserDefaults.has(key: "fakeKey"))
    }

}

// MARK: - Remove

extension UserDefaultsExtensionTests {

    func testRemoveAll() {
        func testRemoveAll() {
            let defaults = UserDefaults.standard
            defaults["a"] = "test1"
            defaults["b"] = "test2"
            let count = defaults.dictionaryRepresentation().count
            XCTAssert(!defaults.dictionaryRepresentation().isEmpty)
            defaults.removeAll()
            XCTAssert(!defaults.has(key: "a"))
            XCTAssert(!defaults.has(key: "b"))
            // We'll still have the system keys present, but our two keys should be gone
            XCTAssert(defaults.dictionaryRepresentation().count == count - 2)
        }
    }

}
