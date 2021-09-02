//
//  ViewController.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/8/23.
//

import UIKit

class MainViewController: UITabBarController {

    private lazy var composedButton: UIButton = UIButton(imageName: "tabbar_compose_icon_add", backImageName: "tabbar_compose_button")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewControllers()
        setupComposedButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.bringSubviewToFront(composedButton)
    }

}

extension MainViewController {
    private func addChildViewControllers() {
        tabBar.tintColor =  UIColor.orange
        addChildViewController(vc: TestTableViewController(), title: "测试", imageName: "tabbar_profile")
        addChildViewController(vc: HomeTableViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(vc: AccountTableViewController(), title: "我", imageName: "tabbar_profile")
    }
    
    
    private func addChildViewController(vc: UIViewController, title:String, imageName:String) {
        vc.title = title
        vc.tabBarItem.image = UIImage(named: imageName)
        let nav = UINavigationController(rootViewController: vc)
        addChild(nav)
    }
    
    private func setupComposedButton() {
        tabBar.addSubview(composedButton)
        let count = children.count
        let w = tabBar.bounds.width/CGFloat(count) - 1
        composedButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        composedButton.addTarget(self, action: #selector(clickComposedButton), for: .touchUpInside)
    }
    
    @objc private func clickComposedButton() {
        print("\(#function)")
    }

}

