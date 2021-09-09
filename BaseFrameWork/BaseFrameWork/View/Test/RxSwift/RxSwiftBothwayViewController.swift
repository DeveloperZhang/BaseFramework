//
//  RxSwiftBothwayViewController.swift
//  BaseFrameWork
//
//  Created by Vicent on 2021/9/9.
//

import UIKit
import RxSwift
import RxCocoa


struct UserViewModel {
    //用户名
    let username =  BehaviorRelay.init(value: "guest")
    //用户信息
    lazy var userinfo = {
        return self.username.asObservable()
            .map{ $0 == "hangge" ? "您是管理员" : "您是普通访客" }
            .share(replay: 1)
    }()
}

class RxSwiftBothwayViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
     
    @IBOutlet weak var label: UILabel!
    
    var userVM = UserViewModel()
         
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //将用户名与textField做双向绑定
        userVM.username.asObservable().bind(to: textField.rx.text).disposed(by: disposeBag)
        textField.rx.text.orEmpty.bind(to: userVM.username).disposed(by: disposeBag)

        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
        

        //双向绑定操作符
//        _ = self.textField.rx.textInput <-->  self.userVM.username
        
        //将用户信息绑定到label上
        userVM.userinfo.bind(to: label.rx.text).disposed(by: disposeBag)
    }

}
