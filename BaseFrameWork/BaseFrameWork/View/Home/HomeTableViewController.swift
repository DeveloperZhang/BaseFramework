//
//  HomeTableViewController.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeTableViewController: UITableViewController {
    
    let CellID = "CellID"
        
    override func viewDidLoad() {
        print("\(#function) in \(#file)")
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
        
        let requestBean = HomeRequestBean()
        requestBean.page = 1
        requestBean.count = 0
    
        let json =  requestBean.object2JSON()
        NetworkingTool.shareInstance.request(url: "/baseFramework/students.json", method: .get, parmas: json.dictionaryValue) { result in
            debugPrint(result)
        } failedCallBack: { error in
//            debugPrint(error)
        }
   
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
        cell.textLabel?.text = "\((NSStringFromClass(type(of: self)) as NSString).components(separatedBy: ".").last!)-Cell\(indexPath.row)"
        return cell
    }
    
    
}
