//
//  MyPageViewController.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SignInFeature
import SignInFeatureInterface
import MyPageFeatureInterface
import RxSwift
import UtilityModule

public class MyPageViewController: UIViewController, ContainerViewType {
    public var contentView: UIView! = UIView()
    
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
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        bind()

    }
    
}

extension MyPageViewController {
    func bind() {
        
        PreferenceManager.$user
            .map({$0 != nil})
            .subscribe(onNext: {[weak self] (isLogin: Bool) in
                
                guard let self else {return}
                
                if isLogin {
                    if  self.children.first as? SignInViewController != nil {
                        self.remove(asChildViewController: self.siginInFactory.makeView())
                    }
                    self.add(asChildViewController: self.myPageContentFactory.makeView())
                } else {
                    if  self.children.first as? MyPageContentViewController != nil {
                        self.remove(asChildViewController: self.myPageContentFactory.makeView())
                    }
                    self.add(asChildViewController: self.siginInFactory.makeView())
                }
                
            })
            .disposed(by: disposeBag)
        
    }
}
