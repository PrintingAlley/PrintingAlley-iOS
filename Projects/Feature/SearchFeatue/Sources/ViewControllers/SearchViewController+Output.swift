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

extension SearchViewController { // TODO: - 텍스트로 검색 결과 데이터 소스 받아오기
    func bindDataSource(input: SearchViewModel.Input, output: SearchViewModel.Output) {
        output.dataSource
            .skip(1)
            .bind(to: printingTableView.rx.items) { [weak self] (tableView, index, model) -> UITableViewCell in
                guard let self = self else {
                    return UITableViewCell()
                }
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = printingTableView.dequeueReusableCell(withIdentifier: PrintingTableViewCell.identifier, for: indexPath) as? PrintingTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.bindData(model: model)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}
