//
//  SignInViewController.swift
//  SignInFeature
//
//  Created by yongbeomkwak on 2023/09/28.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import KakaoSDKCommon

public class SignInViewController: UIViewController {

    lazy var button: UIButton = UIButton().then{
        $0.setTitle("Press", for: .normal)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tap() {
        self.view.showToast(text: "안아마안ㅁㅇㅁ너염ㄴ안ㅁ")
    }
}


