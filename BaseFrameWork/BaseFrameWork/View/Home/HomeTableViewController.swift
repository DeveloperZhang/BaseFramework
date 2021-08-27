//
//  HomeTableViewController.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/23.
//

import UIKit
import Alamofire
import HandyJSON

class HomeTableViewController: UITableViewController {
    
    let CellID = "CellID"
    var viewModel:HomeViewModel = HomeViewModel()
        
    override func viewDidLoad() {
        print("\(#function) in \(#file)")
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
        
        let requestBean = HomeRequestBean()
        requestBean.page = 1
        requestBean.count = 0
    
        let json =  requestBean.toJSON()
        viewModel.requestHomeList(params: json!) { result in
            debugPrint(result)
            self.tableView.reloadData()
        } failedCallBack: { error in
//            debugPrint(error)
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
        cell.textLabel?.text = viewModel.list?[indexPath.row].nameString
        return cell
    }
    
    
}
