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
                
                self.indicatorBar.snp.updateConstraints {
                    $0.left.equalToSuperview().offset(newConstraint)
                }
                self.collectionView.reloadData()
                self.view.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
    }
}
