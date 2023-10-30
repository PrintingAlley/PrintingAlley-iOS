//
//  AlleyPageViewController+Output.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift


extension AlleyPageViewController {
    
    func bindConstraints(output: AlleyPageViewModel.Output) {
        
        output.barConstraints
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { (owner,newConstraint) in
                
                owner.indicaatorBar.snp.updateConstraints {
                    $0.left.equalToSuperview().inset(newConstraint)
                }
    
            })
            .disposed(by: disposeBag)
        
        
    }
    
}
