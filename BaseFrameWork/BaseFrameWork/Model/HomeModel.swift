//
//  HomeModel.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/27.
//

import UIKit
import HandyJSON

class HomeModel: BaseModel,HandyJSON {
    var list:[HomeItemModel]?
    required override init() {
        
    }
}

class HomeItemModel:HandyJSON {
    var id:String?
    var name:String?
    var className:String?
    required init(){} // 必须实现一个空的初始化方法
    
    ///实现一个可选的mapping函数，在里边实现NSString值(HandyJSON会把对应的JSON字段转换为NSString)转换为你需要的字段类型
    public func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.className <-- "class_name"
    }
    
}
