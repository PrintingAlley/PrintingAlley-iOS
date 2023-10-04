//
//  MyPageContentViewController.swift
//  MyPageModule
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import UtilityModule

public class MyPageContentViewController: UIViewController {

    var button: UIButton = UIButton().then {
        $0.setTitle("Click", for: .normal)
    }
    
    var label: UILabel = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        
        self.view.addSubview(button)
        self.view.addSubview(label)
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(action), for: .touchDown)
        
        label.text = PreferenceManager.user?.id
        label.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    @objc func action() {
        PreferenceManager.user = nil
    }
    
}
