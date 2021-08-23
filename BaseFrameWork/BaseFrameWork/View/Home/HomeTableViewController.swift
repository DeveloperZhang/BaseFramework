//
//  HomeTableViewController.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/23.
//

import UIKit
import Alamofire

class HomeTableViewController: UITableViewController {
    
    let CellID = "CellID"
        
    override func viewDidLoad() {
        print("\(#function) in \(#file)")
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
        
        AF.request("http://localhost:8080/students.json").responseJSON { response in
            switch response.result {
                case .success(let result):
                    debugPrint(result)
                    guard let resJson = result as? [String:Any] else {
                        return
                    }
                    let resultJson = resJson["result"] as? [String:Any]
                    debugPrint(resultJson!)
                case .failure(let err):
                    debugPrint(err)
            }
            

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
