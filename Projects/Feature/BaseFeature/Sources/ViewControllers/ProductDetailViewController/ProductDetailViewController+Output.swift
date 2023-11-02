//
//  ProductDetailViewController+Output.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 11/2/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import UtilityModule

extension ProductDetailViewController {
    
    func bindToast(output: ProductDetailViewModel.Output) {
        
        output.showToast
            .withUnretained(self)
            .subscribe(onNext: { (owner, toast) in
                
                owner.view.showToast(text: toast.message)
            })
            .disposed(by: disposeBag)
        
      
    }
}
