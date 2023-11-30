//
//  PrintShopProductsViewController+Output.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/16.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import RxSwift

extension PrintShopProductsViewController {
    func bindItemSelected(output: PrintShopProductsViewModel.Output) {
        
        productsGridView
            .rx
            .itemSelected
            .map({$0.row})
            .subscribe(onNext: { [weak self ]  index in
                
                guard let self else {return}
                
                let vc = self.productDetailFactory.makeView(id: self.viewModel.products[index].id)
                
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
