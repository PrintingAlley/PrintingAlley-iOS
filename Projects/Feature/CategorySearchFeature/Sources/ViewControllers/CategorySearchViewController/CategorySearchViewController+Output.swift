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

extension CategorySearchViewController {
    
    func bindDataSource(output: CategorySearchViewModel.Output) {
        output.dataSource
            .do(onNext: { [weak self] dataSource in
                guard let self else { return }
                self.indicator.stopAnimating()
                // TODO: 검색결과없음 추가
            })
            .map { $0.products }
            .bind(to: gridCollectionView.rx.items) { [weak self] (collectionView, index, model) -> UICollectionViewCell in
                guard let self else { return UICollectionViewCell() }
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCollectionViewCell.identifer, for: indexPath) as? PinterestCollectionViewCell else { return UICollectionViewCell() }
                cell.update(model: model)
                cell.bookmarkButton.isHidden = true
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
