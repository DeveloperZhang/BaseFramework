//
//  TestTableViewController.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/9/1.
//

import UIKit

class TestTableViewController: UITableViewController {
    let CellID = "CellID"
    let dataArray = ["RxSwift"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = SimpleRxViewController()
            navigationController?.pushViewController(vc, animated: true)
            tabBarController?.hidesBottomBarWhenPushed = true
            break
        default:
            break
        }
    }
    
}
