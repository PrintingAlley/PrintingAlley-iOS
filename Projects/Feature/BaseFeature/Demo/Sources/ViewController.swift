//
//  ViewController.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit
import Then

class ViewController: UIViewController {
    
    lazy var label: CarouselCountLabel = CarouselCountLabel(3)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    

  

}
