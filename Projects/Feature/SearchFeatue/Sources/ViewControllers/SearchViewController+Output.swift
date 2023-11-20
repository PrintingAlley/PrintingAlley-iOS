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
    func bindToast(output: SearchViewModel.Output) {
        
        output.showToast
            .withUnretained(self)
            .subscribe(onNext: { (owner, toast) in
                owner.view.showToast(text: toast.message)
            })
            .disposed(by: disposeBag)
    }
    
    func bindDataSource(input: SearchViewModel.Input, output: SearchViewModel.Output) {
        output.dataSource
            .skip(1)
            .do { [weak self] dataSource in
                guard let self else { return }
                DEBUG_LOG("DS: \(dataSource.count)")
                self.indicator.stopAnimating()
                self.printingTableView.tableHeaderView = dataSource.isEmpty ? emptyHeaderView : nil
            }
            .bind(to: printingTableView.rx.items) { [weak self] (tableView, index, model) -> UITableViewCell in

                guard let self else { return UITableViewCell() }
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: PrintShopTableViewCell.identifier) as? PrintShopTableViewCell else { return UITableViewCell() }
                
                cell.selectionStyle = .none
                cell.update(model: model)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    ///  indcator 시작
    func bindIndicator(output: SearchViewModel.Output) {
        output.runIndicator
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else {return}
                self.indicator.startAnimating()
            })
            .disposed(by: disposeBag)
    }
}
