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
import RxDataSources
import UIKit

extension ProductDetailViewController {
    
    func bindToast(output: ProductDetailViewModel.Output) {
        
        output.showToast
            .withUnretained(self)
            .subscribe(onNext: { (owner, toast) in
                
                owner.view.showToast(text: toast.message)
            })
            .disposed(by: disposeBag)
        
    }
    
    
    func bindDataSource(output: ProductDetailViewModel.Output) {
        
        tableView.rx.setDelegate(self)
        
        output.dataInfo
            .map{$0.dataSoruce}
            .bind(to: tableView.rx.items){ (tableView, indexPath ,model) -> UITableViewCell in
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifer, for: IndexPath(row: indexPath, section: 0)) as? ProductDetailTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.update(model: model, index: indexPath)
                
                return cell 
            }
        
    }
}
