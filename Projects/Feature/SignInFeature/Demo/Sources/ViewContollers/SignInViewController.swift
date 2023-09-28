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

class SignInViewController: UIViewController {

    let versionLabel: UILabel = UILabel().then {
        $0.text = "버전정보 \(APP_VERSION())"
        $0.textAlignment = .center
    }
    
    let stackView:UIStackView = UIStackView().then{
        $0.axis = .vertical
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addSubviews()
        makeConstraints()
        DEBUG_LOG("HELLO")
        
        // Do any additional setup after loading the view.
    }
    
}

extension SignInViewController {
    
    func addSubviews() {
        self.view.addSubview(versionLabel)
        self.view.addSubview(stackView)
        
    }
    
    func makeConstraints() {
        
        versionLabel.snp.makeConstraints {
            
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(52)
            
        }
        
        stackView.snp.makeConstraints{
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalTo(versionLabel.snp.top).offset(55)
        }
    }
    
}
