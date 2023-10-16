//
//  ViewController.swift
//  DesignSystemDemo
//
//  Created by yongbeomkwak on 10/15/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {

    var button: UIButton = UIButton().then {
        $0.setTitle("Press", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button)
        self.view.backgroundColor = .white
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
    }
    
    @objc func action() {
        let vc = EditModalViewController(title: "삭제하시겠나요?")
        
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc,animated: false)
    }


}
