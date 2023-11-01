//
//  CategorySearchViewController+Input.swift
//  CategorySearchFeatureDemo
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxCocoa
import UtilityModule
import UIKit

extension CategorySearchViewController {
    
    func bindFilterButton() {
        
        filterButton.rx
            .tap
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in
                
                var filterVc = FilterViewController { result in
                    DEBUG_LOG(result)
                    
                }
                
                filterVc.modalPresentationStyle = .overFullScreen
                
                owner.present(filterVc, animated: true)
                
            })
            .disposed(by: disposeBag)
        
    }
    
}
