//
//  CategorySearchViewController+Output.swift
//  CategorySearchFeature
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import UIKit
import BaseFeature
import BaseDomainInterface
import DesignSystem
import UtilityModule

extension CategorySearchViewController {
    func bindToast(output: CategorySearchViewModel.Output) {
        
        output.showToast
            .withUnretained(self)
            .subscribe(onNext: { (owner, toast) in
                owner.view.showBottomToast(text: toast.message)
            })
            .disposed(by: disposeBag)
    }
    
    func bindDataSource(output: CategorySearchViewModel.Output) {
        output.dataSource
            .skip(1)
            .do(onNext: { [weak self] dataSource in
                guard let self else { return }
                self.indicator.stopAnimating()
                DEBUG_LOG("DS: \(dataSource.count)")
                if output.tags.value.count < 1, dataSource.isEmpty { // 선택한 필터 태그가 없는 상황
                    gridCollectionView.backgroundView = CategoryEmptyHeaderView().then {
                        $0.setTitle(title: "등록된 작품이 아직 없어요.", subtitle: "멋진 작품으로 곧 찾아올게요!")
                        $0.button.isHidden = true
                    }
                } else if dataSource.isEmpty {
                    gridCollectionView.backgroundView = emptyHeaderView
                } else {
                    self.gridCollectionView.restore()
                }
            })
            .bind(to: gridCollectionView.rx.items) { [weak self] (collectionView, index, model) -> UICollectionViewCell in
                guard let self else { return UICollectionViewCell() }
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCollectionViewCell.identifer, for: indexPath) as? PinterestCollectionViewCell else { return UICollectionViewCell() }
                cell.update(model: model)
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    ///  indcator 시작
    func bindIndicator(output: CategorySearchViewModel.Output) {
        output.runIndicator
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else {return}
                
                self.indicator.startAnimating()
            })
            .disposed(by: disposeBag)
    }
}
