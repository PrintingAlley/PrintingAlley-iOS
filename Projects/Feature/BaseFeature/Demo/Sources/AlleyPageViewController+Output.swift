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
            .asDriver()
            .drive(onNext: { [weak self] newConstraint in
                
                guard let self else {return}
                
                
                UIView.animate(withDuration: 0.5 , delay: .zero, options: .curveEaseOut) {
                    
                    self.indicaatorBar.snp.updateConstraints {
                        $0.left.equalToSuperview().offset(newConstraint)
                    }
                    
                    self.view.layoutIfNeeded()
                }
                
               
    
            })
            .disposed(by: disposeBag)
        
        
    }
    
}
