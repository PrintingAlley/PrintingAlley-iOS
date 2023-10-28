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
                
                guard let filterVc = owner.filterFactory.makeView(id: owner.viewModel.id) as? FilterViewController else {
                    return
                }
                
                filterVc.modalPresentationStyle = .overFullScreen
                filterVc.deleagte = owner
                
                owner.present(filterVc, animated: true)
                
            })
            .disposed(by: disposeBag)
        
    }
    
}
