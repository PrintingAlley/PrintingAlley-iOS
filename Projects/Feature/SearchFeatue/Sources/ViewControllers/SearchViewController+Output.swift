//
//  SearchViewController+Output.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import RxSwift
import UIKit
import UtilityModule
import BaseFeature

extension SearchViewController {
    func bindDataSource(input: SearchViewModel.Input, output: SearchViewModel.Output) {
        output.dataSource
            .do { [weak self] dataSource in
                guard let self else { return }
                
                self.printingTableView.tableHeaderView = dataSource.isEmpty ? emptyHeaderView : nil
            }
            .bind(to: printingTableView.rx.items) { [weak self] (tableView, index, model) -> UITableViewCell in
                
                guard let self else { return UITableViewCell() }
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PrintShopTableViewCell.identifier) as? PrintShopTableViewCell else { return UITableViewCell() }
                
                cell.update(model: model)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}
