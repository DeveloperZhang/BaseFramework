//
//  BaseViewModel.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/24.
//

import UIKit
import SwiftyJSON

class BaseViewModel: NSObject {

}

class BaseRequestBean: NSObject{
    
    //子类的
    func object2JSON() -> JSON {
        return JSON()
    }
}
