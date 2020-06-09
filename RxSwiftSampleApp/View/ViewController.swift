//
//  ViewController.swift
//  RxSwiftSampleApp
//
//  Created by 伊藤和也 on 2020/06/09.
//  Copyright © 2020 kazuya ito. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    private let count: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    private let disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.rx.text.orEmpty
        .bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        bindButtonToValue()
        bindCountToText()
        
    }

    // 1.の処理
    private func bindButtonToValue() {
        button.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.increment()})
            .disposed(by: disposeBag)
    }

    private func increment() {
        count.accept(count.value + 1)
    }

    // 2.の処理
    private func bindCountToText() {
        count.asObservable()
            .subscribe(onNext: { [weak self] count in
                self?.label.text = String(count)
                print(count)
            })
            .disposed(by: disposeBag)
    }
    
}

//import UIKit
//import RxSwift
//import RxCocoa
//
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var label: UILabel!
//    @IBOutlet weak var textField: UITextField!
//
//    let disposeBag = DisposeBag()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        textField.rx.text.orEmpty
//        .bind(to: label.rx.text)
//        .disposed(by: disposeBag)
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//}

