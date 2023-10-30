//
//  AlleyPageViewController+Output.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import UIKit


extension AlleyPageViewController {
    
    func bindConstraints(output: AlleyPageViewModel.Output) {
        
        output.barConstraints
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] newConstraint in
                
                guard let self else {return}
                
                self.indicaatorBar.snp.updateConstraints {
                    $0.left.equalToSuperview().offset(newConstraint)
                }
                
                UIView.animate(withDuration: 0.3, delay: .zero, options: .curveEaseOut) {
                    
                    
                    self.view.layoutIfNeeded()
                }
                
               
    
            })
            .disposed(by: disposeBag)
        
        
    }
    
}
