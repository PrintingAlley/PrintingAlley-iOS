//
//  CategorySearchViewController+Output.swift
//  CategorySearchFeatureDemo
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import UIKit
import BaseFeature

extension CategorySearchViewController {
    
    func bindDataSource(output: CategorySearchViewModel.Output) {
        
        output.dataSource
            .do(onNext: { [weak self] dataSource in
                
                guard let self else {return}
                
                if dataSource.isEmpty {
                    self.tableView.tableHeaderView = headerView
                } else {
                    self.tableView.tableHeaderView = nil
                }
        
            })
            .bind(to: tableView.rx.items){ [weak self] (talbeView, index, model) -> UITableViewCell in
                
                guard let self else {return UITableViewCell()}
                
                guard let cell = talbeView.dequeueReusableCell(withIdentifier: PrintShopTableViewCell.identifier) as? PrintShopTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.selectionStyle = .none
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
}
