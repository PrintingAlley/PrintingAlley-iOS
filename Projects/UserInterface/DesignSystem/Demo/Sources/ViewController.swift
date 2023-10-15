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
        button.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
    }
    
    @objc func action(){
        let vc = AlertViewController(title: "삭제하시겠나요?", content: "리스트를 삭제하면 리스트에 저장된\n장소도 함께 삭제됩니다", type: .delete)
        
        self.present(vc,animated: true)
    }


}
