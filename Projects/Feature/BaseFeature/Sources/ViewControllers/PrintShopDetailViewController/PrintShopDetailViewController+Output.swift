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
import UIKit

extension PrintShopDetailViewController {
    func bindDataSource(output: PrintShopDetailViewModel.Output) {
        
        imageCollectionView.delegate = self
        
        output.dataSource
            .skip(1)
            .do(onNext: { [weak self] dataSource in
                guard let self else { return }
                
                update(model: dataSource)
            })
                .map { [$0.logoImage, $0.backgroundImage] }
            .bind(to: imageCollectionView.rx.items) { [weak self] (collectionView, indexPath, model) -> UICollectionViewCell in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrintShopPhotosCollectionViewCell.identifier, for: IndexPath(index: indexPath)) as? PrintShopPhotosCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.update(model: model)
                return cell
            }
            .disposed(by: disposeBag)
    }
}
