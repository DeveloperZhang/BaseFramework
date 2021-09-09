//
//  RxTestBinderViewController.swift
//  BaseFrameWork
//
//  Created by Vicent on 2021/9/9.
//

import UIKit
import RxSwift
import RxCocoa


//TEST1
/*
class RxTestBinderViewController: UIViewController {

    @IBOutlet weak var myLb: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Observable序列（每隔0.5秒钟发出一个索引数）
        let observable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable
            .map { (number) -> CGFloat in
                print(number)
                return (CGFloat(number) + 10)
            }
            .bind(to: myLb.fontSize) //根据索引数不断变放大字体
            .disposed(by: disposeBag)
        
    }
}

extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
*/

//TEST 2
/*
class RxTestBinderViewController: UIViewController {

    @IBOutlet weak var myLb: UILabel!
    
    let disposeBag = DisposeBag()
         
        override func viewDidLoad() {
             
            //Observable序列（每隔0.5秒钟发出一个索引数）
            let observable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            observable
                .map { CGFloat($0) + 14.0}
                .bind(to: myLb.rx.fontSize) //根据索引数不断变放大字体
                .disposed(by: disposeBag)
        }
}

extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}
 */

 
class RxTestBinderViewController: UIViewController {

    @IBOutlet weak var myLb: UILabel!

    let disposeBag = DisposeBag()
     
    override func viewDidLoad() {
         
        //Observable序列（每隔1秒钟发出一个索引数）
        let observable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable
            .map { "当前索引数：\($0 )"}
            .bind(to: myLb.rx.text) //收到发出的索引数后显示到label上
            .disposed(by: disposeBag)
    }
}
