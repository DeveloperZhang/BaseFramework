//
//  HomeTableViewController.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/23.
//

import UIKit
import Alamofire
import HandyJSON
import ProgressHUD

let HomeTableViewCellID = "HomeTableViewCell"
class HomeTableViewController: UITableViewController {
    
    var viewModel:HomeViewModel = HomeViewModel()
        
    override func viewDidLoad() {
        print("\(#function) in \(#file)")
        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
        tableView.register(UINib.init(nibName: HomeTableViewCellID, bundle: nil), forCellReuseIdentifier: HomeTableViewCellID)
        
        let requestBean = HomeRequestBean()
        requestBean.page = 1
        requestBean.count = 0
    
        
        let json =  requestBean.toJSON()
        ProgressHUD.show()
        viewModel.requestHomeList(params: json!) { result in
            debugPrint(result)
            self.tableView.reloadData()
//            ProgressHUD.dismiss()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellID, for: indexPath) as! HomeTableViewCell
        cell.viewModel = viewModel.list?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let vm = viewModel.list?[indexPath.row]
        return vm!.rowHeight
    }
    
    
}
