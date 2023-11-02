//
//  BookMarkBottomSheetViewController+Output.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 11/2/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


extension BookMarkBottomSheetViewController {
 
    func bindDataSource(output: BookMarkBottomSheetViewModel.Output) {
        
        output.dataSource
            .bind(to: tableView.rx.items) { (tableView, index, model) -> UITableViewCell  in
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BookMarkListTableViewCell.identifier, for: indexPath) as? BookMarkListTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.update(model: model)
                cell.selectionStyle = .none
                
                return cell
                
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
