//
//  SearchViewController+Input.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import UtilityModule
import BaseDomainInterface

extension SearchViewController {
    func bindUIEvent(input: SearchViewModel.Input) {
        searchBar.searchTextField.rx.text.orEmpty
            .skip(1)
            .distinctUntilChanged()
            .bind(to: self.input.textString)
            .disposed(by: disposeBag)
    }
    
    func bindTableView() {
        printingTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        printingTableView.rx.willDisplayCell
            .map { $1 }
            .withLatestFrom(output.dataSource, resultSelector: { (indexPath, dataSource) -> (IndexPath, [PrintShopEntity]) in
                return (indexPath, dataSource)
            })
            .filter { (indexPath, dataSources) -> Bool in
                return indexPath.item == dataSources.count - 1
            }
            .withLatestFrom(output.canLoadMore)
            .filter{ $0 }
            .map { _ in return }
            .bind(to: input.loadMore)
            .disposed(by: disposeBag)
    }
    
    func bindItemSelected() {
        printingTableView
            .rx
            .itemSelected
            .map( { $0.row })
            .withLatestFrom(output.dataSource) { ($0, $1) }
            .subscribe(onNext: { [weak self] (index, dataSource) in
                guard let self else { return }
                
                let vc = self.printShopDetailFactory.makeView(id: dataSource[index].id)
                
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
