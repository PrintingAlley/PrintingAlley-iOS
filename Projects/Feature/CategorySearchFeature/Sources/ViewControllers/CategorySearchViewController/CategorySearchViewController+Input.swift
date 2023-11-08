//
//  CategorySearchViewController+Input.swift
//  CategorySearchFeature
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
            .subscribe(onNext: { (owner, _) in
                
                guard let filterVc = owner.filterFactory.makeView(id: owner.viewModel.id) as? FilterViewController else {
                    return
                }
                
                filterVc.modalPresentationStyle = .overFullScreen
                filterVc.deleagte = owner
                
                owner.present(filterVc, animated: true)
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func bindItemSelected() {
        
        gridCollectionView
            .rx
            .itemSelected
            .map{$0.row}
            .withLatestFrom(output.dataSource){($0,$1)}
            .subscribe(onNext: { [weak self] (index,dataSource) in
                
                guard let self else { return }
                
                let vc = self.productDetailFactory.makeView(id: dataSource.products[index].id)
                
                self.navigationController?.pushViewController(vc, animated: true)
            
                
            })
            .disposed(by: disposeBag)
    
        
    }
    
}
