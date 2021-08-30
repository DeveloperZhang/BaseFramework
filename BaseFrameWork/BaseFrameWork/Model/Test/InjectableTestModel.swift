//
//  InjectableTestModel.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/30.
//

import Foundation

class InjectableTestModel {
    
    static func testInject() -> Void {
        let testInject:InjectedClass = InjectedClass()
        testInject.inject(properties: ["key":"abc"])
        testInject.logInject()
    }

}


class InjectedClass: Injectable {
    
    private var objInjected: [String:String]?

    func inject(properties: T) {
        objInjected = properties
    }

    func assertDependencies() {
        assert(objInjected != nil)
    }
    
    func logInject() {
        assertDependencies()
        debugPrint("inject is :\(objInjected!)")
    }
    
    typealias T = [String:String]
    
}
