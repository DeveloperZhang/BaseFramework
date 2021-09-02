//
//  SimpleRxViewController.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/9/1.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleRxViewController: UIViewController {

    
    @IBOutlet weak var usernameTFOutlet: UITextField!
    @IBOutlet weak var usernameValidLbOutlet: UILabel!

    @IBOutlet weak var passwordTFOutlet: UITextField!
    @IBOutlet weak var passwordValidLbOutlet: UILabel!

    @IBOutlet weak var submitBtnOutlet: UIButton!
    
    
    let disposeBag = DisposeBag()
    let minimalStringLength = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameValidLbOutlet.text = "Username has to be at least \(minimalStringLength) characters"
        passwordValidLbOutlet.text = "Password has to be at least \(minimalStringLength) characters"
        
        let usernameValid = usernameTFOutlet.rx.text.orEmpty
            .map{$0.count >= self.minimalStringLength}.share(replay:1)
        usernameValid.bind(to: usernameValidLbOutlet.rx.isHidden).disposed(by: disposeBag)
        usernameValid.bind(to: passwordTFOutlet.rx.isEnabled).disposed(by: disposeBag)
        
        let passwordValid = passwordTFOutlet.rx.text.orEmpty
            .map{$0.count >= self.minimalStringLength}.share(replay:1)
        passwordValid.bind(to: passwordValidLbOutlet.rx.isHidden).disposed(by: disposeBag)
        
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid){
            $0 && $1
        }.share(replay:1)
        everythingValid.bind(to: submitBtnOutlet.rx.isEnabled).disposed(by: disposeBag)
        
        submitBtnOutlet.rx.tap.subscribe(onNext:{
            [weak self] in self?.showAlert()
        }).disposed(by: disposeBag)
        
        
    }

    func showAlert() {
        let alertVC = UIAlertController.init(title: "RxExample", message: "This is wonderful", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel)
        alertVC.addAction(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }

}
