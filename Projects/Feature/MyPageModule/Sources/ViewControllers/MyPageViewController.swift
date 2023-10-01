//
//  MyPageViewController.swift
//  MyPageModule
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SignInFeatureInterface
import MyPageModuleInterface
import RxSwift

public class MyPageViewController: UIViewController {
    
    var siginInFactory: SigninFactory!
    var myPageContentFactory: MyPageContentFactory!
    
    let disposeBag = DisposeBag()

    init(siginInFactory: SigninFactory, myPageContentFactory: MyPageContentFactory) {
        super.init(nibName: nil, bundle: nil)
        self.siginInFactory = siginInFactory
        self.myPageContentFactory = myPageContentFactory
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension MyPageViewController {
    func bind(){
        
    }
}
