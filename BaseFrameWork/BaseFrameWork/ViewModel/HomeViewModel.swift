//
//  HomeViewModel.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/24.
//

import UIKit
import HandyJSON


class HomeViewModel:BaseViewModel,HandyJSON {
    //请求路径
    let requestUri = "/baseFramework/students1.json"
    var list:[HomeCellModel]?
    required override init() {
        
    }
}

extension HomeViewModel {
    
    public func requestHomeList(params:[String:Any], successCallBack:@escaping NetSuccessCallBack, failedCallBack:@escaping NetFailCallBack) {
        NetworkingTool.shareInstance.request(url:requestUri, method: .get, parmas: params) { result in
            debugPrint(result)
            self.paraseResult(resultJson: result as! [String : Any]) { result in
                successCallBack(result)
            }  failedCallBack: { error in
                failedCallBack(error)
            }
        } failedCallBack: { error in
            debugPrint(error)
            failedCallBack(error)
        }
    }
    
    public func paraseResult(resultJson:[String:Any], successCallBack:@escaping NetSuccessCallBack, failedCallBack:@escaping NetFailCallBack) {
        if let responseModel = JSONDeserializer<HomeModel>.deserializeFrom(dict: resultJson) {
            print("返回数据为:\(responseModel.toJSONString(prettyPrint: true)!)")
            self.parseModelToVM(model: responseModel)
            print("ViewModel的返回数据为:\(self.toJSONString(prettyPrint: true)!)")
            successCallBack(self)
        }else {
            let error = NSError.init(domain: "paraseResultError", code: -110, userInfo: [:])
            failedCallBack(error)
        }
    }
    
    
    public func parseModelToVM(model:HomeModel) {
        self.list = []
        for itemModel in model.list! {
            let cellVM = HomeCellModel()
            cellVM.parseModelToVM(model: itemModel)
            self.list?.append(cellVM)
        }
        self.isNetSuccess = true
    }
}


class HomeCellModel:BaseViewModel,HandyJSON {
    var idStr:String?
    var nameString:String?
    var classNameString:String?
    var contentLbString:String?
    lazy var rowHeight:CGFloat = {
        var cell:HomeTableViewCell
        cell = HomeTableViewCell.createCell()
        return cell.rowHeight(vm: self)
    }()
    
    required override init() {
        
    }
    
    public func parseModelToVM(model:HomeItemModel) {
        idStr = model.id
        nameString = "name:\(model.name ?? "")"
        classNameString = model.className
        contentLbString = model.content
    }
    

    
}

class HomeRequestBean:BaseRequestBean {
    //页数
    var page: Int?
    //每页显示数量
    var count: Int?
    
}
