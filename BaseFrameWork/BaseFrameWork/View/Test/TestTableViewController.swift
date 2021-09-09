//
//  TestTableViewController.swift
//  BaseFrameWork
//
//  Created by ZhangYu on 2021/9/1.
//

import UIKit
import RxSwift

class TestTableViewController: UITableViewController {
    let CellID = "CellID"
    let dataArray = ["0-RxSwift","1-RxSwift Base","2-RxSwift Binder","3-RxSwift Exchange","4-RxSwift 错误","5-RxSwift 双向绑定"]
    
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellID)
        testRx()
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
        case 1:
//            simpleObservableOf()
//            testPublishSubject()
//            testBehaviorSubject()
            testReplaySubject()
//            testVariable()
            break
            
        case 2:
            let vc = RxTestBinderViewController()
            navigationController?.pushViewController(vc, animated: true)
            tabBarController?.hidesBottomBarWhenPushed = true
            break
        case 3:
//            testBuffer()
//            testWindow()
//            testMap()
//            testFlatMap()
//            testFlatMapLatest()
//            testConcatMap()
//            testScan()
//            testGroupBy()
//            testFilter()
//            testDistinctUntilChanged()
//            testSingle()
//            testElementAt()
//            testIgnoreElements()
            testTake()
            break
        case 4:
            break
        case 5:
            let vc = RxSwiftBothwayViewController()
            navigationController?.pushViewController(vc, animated: true)
            tabBarController?.hidesBottomBarWhenPushed = true
            break
        default:
            break
        }
    }
    
    func testRx() {
//        testtakeLast()
//        testskip()
//        testSample()
//        testDebounce()
        //错误
//        testError()
//        testretry()
        
    }
    
    
    enum MyError: Error {
        case A
        case B
    }
    
    func testError() {
        let sequenceThatFails = PublishSubject<String>()
         
        sequenceThatFails
            .catchErrorJustReturn("错误")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
    }
    
    func testretry() {
        var count = 1
         
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("a")
            observer.onNext("b")
             
            //让第一个订阅时发生错误
            if count < 3 {
                observer.onError(MyError.A)
                print("Error encountered")
                count += 1
            }
             
            observer.onNext("c")
            observer.onNext("d")
            observer.onCompleted()
             
            return Disposables.create()
        }
         
        sequenceThatErrors
            .retry(3)  //重试2次（参数为空则只重试一次）
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //debounce 操作符可以用来过滤掉高频产生的元素，它只会发出这种元素：该元素产生后，一段时间内没有新元素产生。
    func testDebounce() {
        //定义好每个事件里的值以及发送的时间
                let times = [
                    [ "value": 1, "time": 0.1 ],
                    [ "value": 2, "time": 1.1 ],
                    [ "value": 3, "time": 1.2 ],
                    [ "value": 4, "time": 1.2 ],
                    [ "value": 5, "time": 1.4 ],
                    [ "value": 6, "time": 2.1 ]
                ]
                 
            //生成对应的 Observable 序列并订阅
        Observable.from(times)
            .flatMap { item in
                return Observable.of(Int(item["value"]!))
                    .delaySubscription(RxTimeInterval.milliseconds(Int(item["time"]! * 1000)),
                                       scheduler: MainScheduler.instance)
            }
            .debounce(RxTimeInterval.milliseconds(Int(0.5 * 1000)), scheduler: MainScheduler.instance) //只发出与下一个间隔超过0.5秒的元素
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    /*
     Sample 除了订阅源Observable 外，还可以监视另外一个 Observable， 即 notifier 。
     每当收到 notifier 事件，就会从源序列取一个最新的事件并发送。而如果两次 notifier 事件之间没有源序列的事件，则不发送值。

    */
    func testSample() {
        let source = PublishSubject<Int>()
        let notifier = PublishSubject<String>()
         
        source
            .sample(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        source.onNext(1)
         
        //让源序列接收接收消息
        notifier.onNext("A")
         
        source.onNext(2)
         
        //让源序列接收接收消息
        notifier.onNext("B")
        notifier.onNext("C")
         
        source.onNext(3)
        source.onNext(4)
         
        //让源序列接收接收消息
        notifier.onNext("D")
         
        source.onNext(5)
         
        //让源序列接收接收消息
        notifier.onCompleted()
    }
    
    //该方法用于跳过源 Observable 序列发出的前 n 个事件。
    func testskip() {
        let disposeBag = DisposeBag()
         
        Observable.of(1, 2, 3, 4)
            .skip(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //该方法实现仅发送 Observable序列中的后 n 个事件。
    func testtakeLast() {
        let disposeBag = DisposeBag()
         
        Observable.of(1, 2, 3, 4)
            .takeLast(1)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }

    
    //该方法实现仅发送 Observable 序列中的前 n 个事件，在满足数量之后会自动 .completed。
    func testTake() {
        let disposeBag = DisposeBag()
         
        Observable.of(1, 2, 3, 4)
            .take(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //如果我们并不关心 Observable 的任何元素，只想知道 Observable 在什么时候终止，那就可以使用 ignoreElements 操作符。
    func testIgnoreElements() {
        Observable.of(1, 2, 3, 4)
            .ignoreElements()
            .subscribe{
                print($0)
            }
            .disposed(by: disposeBag)
    }
    
    
    //该方法实现只处理在指定位置的事件。
    func testElementAt() {
        Observable.of(1, 2, 3, 4)
            .elementAt(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    /*
     限制只发送一次事件，或者满足条件的第一个事件。
     如果存在有多个事件或者没有事件都会发出一个 error 事件。
     如果只有一个事件，则不会发出 error事件。
     */
    func testSingle() {
        Observable.of(1, 2, 3, 4)
            .single{ $0 == 2 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        Observable.of("A", "B", "C", "D")
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        Observable.of("E")
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //该操作符用于过滤掉连续重复的事件。
    func testDistinctUntilChanged() {
        Observable.of(1, 2, 3, 1, 1, 4)
            .distinctUntilChanged()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //该操作符就是用来过滤掉某些不符合要求的事件。
    func testFilter() {
        Observable.of(2, 30, 22, 5, 60, 3, 40 ,9)
            .filter {
                $0 > 10
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //将元素通过某个键进行分组，然后将分组后的元素序列以 Observable 的形态发送出来。
    func testGroupBy() {
        let disposeBag = DisposeBag()
         
        //将奇数偶数分成两组
        Observable<Int>.of(0, 1, 2, 3, 4, 5)
            .groupBy(keySelector: { (element) -> String in
                return element % 2 == 0 ? "偶数" : "基数"
            })
            .subscribe { (event) in
                switch event {
                case .next(let group):
                    group.asObservable().subscribe({ (event) in
                        print("key：\(group.key)    event：\(event)")
                    })
                    .disposed(by: disposeBag)
                default:
                    print("")
                }
            }
        .disposed(by: disposeBag)
    }
    
    //scan 就是先给一个初始化的数，然后不断的拿前一个结果和最新的值进行处理操作。
    func testScan(){
        Observable.of(1, 2, 3, 4, 5)
            .scan(0) { acum, elem in
                acum + elem
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    //等待前一个 Observable 产生完成事件后，才对后一个 Observable 进行订阅
    func testConcatMap() {
         
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
         
        let variable = BehaviorSubject(value:subject1)
         
        variable.asObservable()
            .concatMap { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        subject1.onNext("B")
        variable.onNext(subject2)
        subject2.onNext("2")
        subject1.onNext("C")
        subject1.onCompleted() //只有前一个序列结束后，才能接收下一个序列
    }
    
    /*
      * 当原序列有新的事件发生的时候，flatMapLast 会自动取消上一个事件的订阅，转到新的事件的订阅上面,flatMap则会订阅全部。
     */
    func testFlatMapLatest() {
         
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
         
        let variable = BehaviorSubject(value:subject1)
         
        variable.asObservable()
            .flatMapLatest { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        subject1.onNext("B")
        variable.onNext(subject2)
        subject2.onNext("2")
        subject1.onNext("C")
    }
    
    
    func testFlatMap() {
         
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
         
        let variable = BehaviorSubject(value:subject1)
         
        variable.asObservable()
            .flatMap { $0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
         
        subject1.onNext("B")
        variable.onNext(subject2)
        subject2.onNext("2")
        subject1.onNext("C")
    }
    
    func testMap() {
        let disposeBag = DisposeBag()
         
        Observable.of(1, 2, 3)
            .map { $0 * 10}
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
    
    func testBuffer() {
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
        //每缓存3个元素则组合起来一起发出。
        //如果1秒钟内不够3个也会发出（有几个发几个，一个都没有发空数组 []）
        subject
            .buffer(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
 
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
         
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }
    
    func testWindow() {
        //每3个元素作为一个子Observable发出。
        let subject = PublishSubject<String>()
        subject
            .window(timeSpan: RxTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self]  in
                print("subscribe: \($0)")
                $0.asObservable()
                    .subscribe(onNext: { print($0) })
                    .disposed(by: self!.disposeBag)
            })
            .disposed(by: disposeBag)
         
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
         
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
    }
    
    func simpleObservableOf() {
        //Test1
        /*
        let observale = Observable.of("A", "B")
        
        let _ = observale.subscribe { event in
//            print(event)
            print(event.element ?? "")
        }
         */
        
        //Test2 可以自动解包数据
        /*
        let observable = Observable.of("A", "B", "C")
                 
        let _ = observable.subscribe(onNext: {
            print($0)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("completed")
        }, onDisposed: {
            print("disposed")
        })
        */
        
        //TEST3
        /*
        let observable = Observable.of("A", "B", "C")
                 
        observable.subscribe(onNext: { element in
            print(element)
        })
        */
        
        //TEST4
        /*
        //doOn 方法来监听事件的生命周期，它会在每一次事件发送前被调用。
        let observable = Observable.of("A", "B", "C")
        
        observable
            .do(onNext: { element in
                print("Intercepted Next：", element)
            }, onError: { error in
                print("Intercepted Error：", error)
            }, onCompleted: {
                print("Intercepted Completed")
            }, onDispose: {
                print("Intercepted Disposed")
            })
            .subscribe(onNext: { element in
                print(element)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            })
        */
        
        //TEST5
        /*
        let observable = Observable.of("A", "B", "C")
                 
        //使用subscription常量存储这个订阅方法
        let subscription = observable.subscribe { event in
            print(event)
        }
                 
        //调用这个订阅的dispose()方法
        subscription.dispose()
         */
        
        
        //TEST6
        /*
        let disposeBag = DisposeBag()
                 
        //第1个Observable，及其订阅
        let observable1 = Observable.of("A", "B", "C")
        observable1.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
         
        //第2个Observable，及其订阅
        let observable2 = Observable.of(1, 2, 3)
        observable2.subscribe { event in
            print(event)
        }.disposed(by: disposeBag)
         */
        
        
        //TEST7
        /*
        //这个block有一个回调参数observer就是订阅这个Observable对象的订阅者
        //当一个订阅者订阅这个Observable对象的时候，就会将订阅者作为参数传入这个block来执行一些内容
        let observable = Observable<String>.create{observer in
            //对订阅者发出了.next事件，且携带了一个数据"hangge.com"
            observer.onNext("hangge.com")
            //对订阅者发出了.completed事件
            observer.onCompleted()
            //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
            return Disposables.create()
        }
        //订阅测试
        observable.subscribe {
            print($0)
        }
         */
        
        
        
        //TEST8
        /*
        //用于标记是奇数、还是偶数
        var isOdd = true
         
        //使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        let factory : Observable<Int> = Observable.deferred {
             
            //让每次执行这个block时候都会让奇、偶数进行交替
            isOdd = !isOdd
             
            //根据isOdd参数，决定创建并返回的是奇数Observable、还是偶数Observable
            if isOdd {
                return Observable.of(1, 3, 5 ,7)
            }else {
                return Observable.of(2, 4, 6, 8)
            }
        }
         
        //第1次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
         
        //第2次订阅测试
        factory.subscribe { event in
            print("\(isOdd)", event)
        }
         */
        
        
        
       //Test 9
        /*
         //每 1 秒发送一次，并且是在主线程（MainScheduler）发送
        let observable = Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }
         */
        
        //TEST 10
        /*
        //5秒种后发出唯一的一个元素0
        let observable = Observable<Int>.timer(RxTimeInterval.seconds(5), scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }
         */
        
        
        //TEST 11
        //延时5秒种后，每隔1秒钟发出一个元素
        let observable = Observable<Int>.timer(RxTimeInterval.seconds(5), period: RxTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        observable.subscribe { event in
            print(event)
        }
        
        
    }
    
    func testPublishSubject() {
        let disposeBag = DisposeBag()
         
        //创建一个PublishSubject
        let subject = PublishSubject<String>()
         
        //由于当前没有任何订阅者，所以这条信息不会输出到控制台
        subject.onNext("111")
         
        //第1次订阅subject
        subject.subscribe(onNext: { string in
            print("第1次订阅：", string)
        }, onCompleted:{
            print("第1次订阅：onCompleted")
        }).disposed(by: disposeBag)
         
        //当前有1个订阅，则该信息会输出到控制台
        subject.onNext("222")
         
        //第2次订阅subject
        subject.subscribe(onNext: { string in
            print("第2次订阅：", string)
        }, onCompleted:{
            print("第2次订阅：onCompleted")
        }).disposed(by: disposeBag)
         
        //当前有2个订阅，则该信息会输出到控制台
        subject.onNext("333")
         
        //让subject结束
        subject.onCompleted()
         
        //subject完成后会发出.next事件了。
        subject.onNext("444")
         
        //subject完成后它的所有订阅（包括结束后的订阅），都能收到subject的.completed事件，
        subject.subscribe(onNext: { string in
            print("第3次订阅：", string)
        }, onCompleted:{
            print("第3次订阅：onCompleted")
        }).disposed(by: disposeBag)
    }
    
    func testBehaviorSubject() {
        let disposeBag = DisposeBag()
         
        //创建一个BehaviorSubject
        let subject = BehaviorSubject(value: "111")
         
        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
        }.disposed(by: disposeBag)
         
        //发送next事件
        subject.onNext("222")
         
        //发送error事件
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
         
        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
        }.disposed(by: disposeBag)
        subject.onNext("333")
    }
    
    func testReplaySubject() {
        let disposeBag = DisposeBag()
         
        //创建一个bufferSize为2的ReplaySubject
        let subject = ReplaySubject<String>.create(bufferSize: 2)
         
        //连续发送3个next事件
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")
         
        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
        }.disposed(by: disposeBag)
         
        //再发送1个next事件
        subject.onNext("444")
         
        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
        }.disposed(by: disposeBag)
         
        //让subject结束
        subject.onCompleted()
         
        //第3次订阅subject
        subject.subscribe { event in
            print("第3次订阅：", event)
        }.disposed(by: disposeBag)
        
    }
    
    func testVariable() {
        //已启用无法使用,推荐使用 BehaviorRelay 或者 BehaviorSubject。
        /*
        let disposeBag = DisposeBag()
        //创建一个初始值为111的Variable
        let variable = Variable("111")
        //修改value值
        variable.value = "222"
        //第1次订阅
        variable.asObservable().subscribe {
            print("第1次订阅：", $0)
        }.disposed(by: disposeBag)
        //修改value值
        variable.value = "333"
        //第2次订阅
        variable.asObservable().subscribe {
            print("第2次订阅：", $0)
        }.disposed(by: disposeBag)
        //修改value值
        variable.value = "444"
         */
    }
     
    
}
