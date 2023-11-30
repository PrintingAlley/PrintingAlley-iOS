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
import BaseDomainInterface

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
                filterVc.setPreTags(preTags: owner.output.tags.value)
                
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
                
                let vc = self.productDetailFactory.makeView(id: dataSource[index].id)
                
                vc.hidesBottomBarWhenPushed = true // 탭바 내림
                
                self.navigationController?.pushViewController(vc, animated: true)
            
            })
            .disposed(by: disposeBag)
    
    }
    
    func bindGridView() {
        gridCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        gridCollectionView.rx.willDisplayCell
            .map { $1 }
            .withLatestFrom(output.dataSource, resultSelector: { (indexPath, datasource) -> (IndexPath, [ProductEntity]) in
                return (indexPath, datasource)
            })
            .filter{ (indexPath, datasources) -> Bool in
                return indexPath.item == datasources.count - 1
            }
            .withLatestFrom(output.canLoadMore)
            .filter{ $0 }
            .map { _ in return }
            .do(onNext: { [weak self] _ in
                guard let self else {return }
                self.input.isFetchByScroll.accept(true)
            })
            .bind(to: input.loadMore)
            .disposed(by: disposeBag)
    }
}
