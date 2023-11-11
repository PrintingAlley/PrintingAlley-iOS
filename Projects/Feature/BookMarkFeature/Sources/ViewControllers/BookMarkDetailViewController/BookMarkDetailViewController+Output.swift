//
//  BookMarkDetailViewController+Output.swift
//  BookMarkFeature
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources
import UIKit
import BookMarkDomainInterface
import BaseFeature

extension BookMarkDetailViewController {
    func bindDataSource(input: BookMarkDetailViewModel.Input, output: BookMarkDetailViewModel.Output) {
        
        output.dataSource
            .do(onNext: { [weak self] dataSource in
                
                guard let self else {return}
                
                self.naviTitleLabel.setTitle(title: dataSource.name, textColor: .sub(.black), font: .header3,alignment: .center)
                self.countLabel.setTitle(title: "작품 \(dataSource.bookmarks.count)개", textColor: .grey(.grey400), font: .caption1, alignment: .center)
                
                if dataSource.bookmarks.isEmpty {
                    self.gridCollectionView.setEmptyMessage("저장된 작품이 없습니다.")
                }
                
                else {
                    self.gridCollectionView.restore()
                }
                
            })
            .map{$0.bookmarks}
            .bind(to: gridCollectionView.rx.items){ [weak self]  (collectionView,indexPath,model) -> UICollectionViewCell in
                
                guard let self else {return UICollectionViewCell()}
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:PinterestCollectionViewCell.identifer, for: IndexPath(row: indexPath, section: 0)) as? PinterestCollectionViewCell else {
                    return UICollectionViewCell()
                }
                
                cell.update(model: model.product, isBookMark: true, id: model.id)
                cell.delegate = self  // 삭제 델리 게이트
                
                return cell
            }
            .disposed(by: disposeBag)
        
    }
    
    func bindItemSelected(output: BookMarkDetailViewModel.Output) {
       
    }
    
    
    func bindShowToast(input: BookMarkDetailViewModel.Input, output: BookMarkDetailViewModel.Output) {
        
        output.showToast
            .withUnretained(self)
            .subscribe(onNext: { (owner,result) in
                
                
                if result.statusCode == 200 {
                    owner.view.showToast(text: "성공적으로 제거햇습니다.")
                    input.fetchDataSource.onNext(()) // 업데이트
                }
                
                else {
                    owner.view.showToast(text: result.message)
                }
                
            })
            .disposed(by: disposeBag)
        
    }
}
