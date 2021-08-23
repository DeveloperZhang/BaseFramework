//
//  AccountTableViewController.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/23.
//

import UIKit

class AccountTableViewController: UITableViewController {
        
    let CellID = "CellID"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
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
