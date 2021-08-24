//
//  HomeViewModel.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/24.
//

import UIKit
import SwiftyJSON

class HomeViewModel: BaseViewModel {

}

class HomeRequestBean:BaseRequestBean,Encodable {
    //页数
    var page: Int?
    //每页显示数量
    var count: Int?
    
    override func object2JSON() -> JSON {
        let encoder = JSONEncoder()
                // 默认 outputFormatting 属性值为 .compact，输出效果如上。如果将其改为 .prettyPrinted 后就能获得更好的阅读体检
        encoder.outputFormatting = .prettyPrinted
        var json: JSON = JSON();
        // 将 Beer 实例转化为 JSON
        let jsonData2 = try! encoder.encode(self)
        print(String(bytes: jsonData2, encoding: String.Encoding.utf8) ?? "")
        do {
            try json = JSON.init(data: jsonData2)
            debugPrint(json.dictionaryValue)
        } catch {
            debugPrint(error)
        }
        return json
    }
}
