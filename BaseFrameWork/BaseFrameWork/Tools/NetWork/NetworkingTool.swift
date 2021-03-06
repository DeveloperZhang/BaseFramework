//
//  NetworkingTool.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/23.
//

import UIKit
import Alamofire
import HandyJSON

//成功失败回调
typealias NetSuccessCallBack = (_ response: AnyObject) -> Void
typealias NetFailCallBack = (_ error: AnyObject) -> Void

class NetworkingTool: NSObject {

    //网络请求路径
    let baseUrlPath = "http://localhost:8080"
    let basePicPath = ""
    let baseH5Path = ""

    //枚举类型
    enum NetRequestMethod: String {
        case get = "get"
        case post = "post"
    }
    
    
    
    //单例方法
    static let shareInstance: NetworkingTool = {
        debugPrint("创建网络对象")
        return NetworkingTool()
    }()
    //构建路径
    
    /// 获取baseURL
    public func baseUrl() -> String? {
        let apiURL = URL(string: baseUrlPath)?.absoluteString
        return apiURL
    }
    
    //中文路径encoding
    public func encodingURL(path: String) -> String? {
        return path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    //拼接baseurl生成完整url
    public func absoluteUrlWithPath(path: String?) -> String? {
        if path == nil
            || path?.count == 0 {
            return ""
        }
        if self.baseUrl() == nil
            || self.baseUrl()?.count == 0 {
            return path!
        }
        var absoluteUrl = path
        if !(path?.hasPrefix("http://"))!
            && !(path?.hasPrefix("https://"))! {
            if (path?.hasPrefix("/"))! {
                absoluteUrl = self.baseUrl()! + path!
            } else {
                absoluteUrl = self.baseUrl()! + "/" + path!
            }
        }
        return absoluteUrl
    }
    //网络请求方法
    
    /// 网络请求基本方法
    ///
    /// - Parameters:
    ///   - url:                  String:请求路径
    ///   - method:               NetRequestMethod:请求方法类型
    ///   - params:               [String: Any]:请求参数
    ///   - successCallBack:      NetSuccessCallBack:成功回调
    ///   - failedCallBack:       NetFailCallBack:失败回调
    public func request(url: String, method:HTTPMethod, parmas:[String: Any],
                        successCallBack:@escaping NetSuccessCallBack, failedCallBack:@escaping NetFailCallBack) {
        let encodingUrl = encodingURL(path: url)
        let absolute = absoluteUrlWithPath(path: encodingUrl)
        guard let requestUrl = absolute else {
            debugPrint("请求路径有问题")
            return
        }
        
        debugPrint("请求路径为:\(requestUrl)")
        debugPrint("请求参数为:\(parmas)")
        
        
        AF.request(requestUrl, method: method, parameters: parmas, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
                case .success(let jsonData):
                    debugPrint(jsonData)
                    guard let resultJson = jsonData as? [String:Any] else {
                        return
                    }
                    guard let resultJson = resultJson["result"] as? [String:Any] else {
                        return
                    }
                    print("返回数据为:\(resultJson)")
                    successCallBack(resultJson as AnyObject)
                    
                    
//                    if let responseModel = JSONDeserializer<HomeViewModel>.deserializeFrom(dict: listJson) {
//                        print("返回数据为:\(responseModel.toJSONString(prettyPrint: true)!)")
//                        successCallBack(responseModel as AnyObject)
//                    }
                case .failure(let error):
                    failedCallBack(error as AnyObject)
                    debugPrint(error)
                }
        }
        
        
//        if method == .get { //get请求
//            getRequest(url: requestUrl, parmas: parmas, successCallBack: successCallBack, failedCallBack: failedCallBack)
//        }else {
//            postRequest(url: requestUrl, parmas: parmas, successCallBack: successCallBack, failedCallBack: failedCallBack)
//        }
        
    }
    
    /// GET请求基本方法
    ///
    /// - Parameters:
    ///   - url:                  String:请求路径
    ///   - params:               [String: Any]:请求参数
    ///   - successCallBack:      NetSuccessCallBack:成功回调
    ///   - failedCallBack:       NetFailCallBack:失败回调
    public func getRequest(url: String, parmas:[String: Any],
                            successCallBack:@escaping NetSuccessCallBack, failedCallBack:@escaping NetFailCallBack) {
        AF.request(url, method: .get, parameters: parmas, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
                case .success(let jsonData):
                    successCallBack(jsonData as AnyObject)
                    debugPrint(jsonData)
                case .failure(let error):
                    failedCallBack(error as AnyObject)
                    debugPrint(error)
                }
        }
        
    }
    
    /// POST请求基本方法
    ///
    /// - Parameters:
    ///   - url:                  String:请求路径
    ///   - params:               [String: Any]:请求参数
    ///   - successCallBack:      NetSuccessCallBack:成功回调
    ///   - failedCallBack:       NetFailCallBack:失败回调
    public func postRequest(url: String, parmas:[String: Any],
                            successCallBack:@escaping NetSuccessCallBack, failedCallBack:@escaping NetFailCallBack) {
        AF.request(url, method: .post, parameters: parmas, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
                case .success(let jsonData):
                    successCallBack(jsonData as AnyObject)
                    debugPrint(jsonData)
                case .failure(let error):
                    failedCallBack(error as AnyObject)
                    debugPrint(error)
            }
        }
        
    }

}

