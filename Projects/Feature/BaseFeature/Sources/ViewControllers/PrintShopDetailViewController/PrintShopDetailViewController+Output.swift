//
//  PrintShopDetailViewController+Output.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/15.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxDataSources
import UIKit

extension PrintShopDetailViewController {
    func bindToast(output: PrintShopDetailViewModel.Output) {
        
        output.showToast
            .withUnretained(self)
            .subscribe(onNext: { (owner, toast) in
                owner.view.showBottomToast(text: toast.message)
            })
            .disposed(by: disposeBag)
    }
    
    func bindDataSource(output: PrintShopDetailViewModel.Output) {
        
        imageCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        output.dataSource
            .skip(1)
            .do(onNext: { [weak self] dataSource in
                guard let self else { return }

                self.indicator.stopAnimating()
                update(model: dataSource)
            })
            .map { $0.backgroundImage.isEmpty ? [$0.logoImage] : [$0.logoImage,$0.backgroundImage] }
            .bind(to: imageCollectionView.rx.items) { [weak self] (collectionView, indexPath, model) -> UICollectionViewCell in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrintShopPhotosCollectionViewCell.identifier, for: IndexPath(index: indexPath)) as? PrintShopPhotosCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.update(model: model)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    ///  indcator 시작
    func bindIndicator(output: PrintShopDetailViewModel.Output) {
        output.runIndicator
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else {return}
                self.indicator.startAnimating()
            })
            .disposed(by: disposeBag)
    }
}
