//
//  SimpleRxTableViewController.swift
//  BaseFrameWork
//
//  Created by Vicent on 2021/9/9.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleRxTableViewController: UITableViewController {
    let CellID = "CellID"
    let dataArray = ["RxSwift","RxSwift Base"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source



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
            simpleObservableOf()
            break
        default:
            break
        }
    }
    
    func simpleObservableOf() {
        let observale = Observable.of("A", "B")
        
        let _ = observale.subscribe { event in
            print(event)
        }
    }
    
}
