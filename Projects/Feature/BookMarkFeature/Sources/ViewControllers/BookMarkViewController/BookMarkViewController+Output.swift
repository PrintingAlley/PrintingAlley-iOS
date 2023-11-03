//
//  BookMarkViewController+Output.swift
//  BookMarkFeature
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import DesignSystem
import RxSwift
import UIKit
import RxCocoa

extension BookMarkViewController {
    
    /// DataSource 바인딩
    func bindDataSource(input: BookMarkViewModel.Input, output: BookMarkViewModel.Output) {
        
        output.dataSource
            .skip(1)
            .do(onNext: { [weak self] dataSource in
                guard let self else {return}
                self.indicator.stopAnimating()
                
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
                
            })
            .bind(to: collectionView.rx.items) { collectionView,index,model -> UICollectionViewCell in
                
                let indexPath = IndexPath(row: index, section: 0)
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookMarkCollectionViewCell.identifer, for: indexPath) as? BookMarkCollectionViewCell  else {
                    return UICollectionViewCell()
                }
                
                cell.update(model: model)
                
                
                
                return cell
                
                
                
            }
            .disposed(by: disposeBag)
        

        
    }
    
    
    
    /// 아이템 선택 이벤트 바인딩
    func bindIndexOfSelectedItem(output: BookMarkViewModel.Output) {
        
        output.indexOfSelectedItem
            .subscribe(onNext:{ [weak self] selectedIndex in
                
                guard let self else {return}
                
                self.deleteButton.isEnabled = !selectedIndex.isEmpty
                
                // 선택된게 비어있으면 삭제는 비활성 화
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func bindResult(input: BookMarkViewModel.Input ,output: BookMarkViewModel.Output) {
        output
            .showToast
            .subscribe(onNext: { [weak self] result in
                
                
                guard let self else {return}
                
                
                if result.statusCode == 0 {
                    self.view.showToast(text: result.message)
                }
                
                else if result.statusCode == 401 {
                    self.view.showToast(text: result.message)
                    // TODO: 토큰 exired 경우 LOGOUT
                }
                
                else {
                    
                    input.fetchDataSource.onNext(())
                    input.isEdit.accept(false)
                    
                }
            })
            .disposed(by: disposeBag)
    }
    
    ///  indcator 시작
    func bindIndicator(output: BookMarkViewModel.Output) {
        output.runIndicator
            .asDriver()
            .drive(onNext: { [weak self] _ in
                guard let self else {return}
                
                self.indicator.startAnimating()
                
                
            })
            .disposed(by: disposeBag)
    }
    
    /// 셀 선택
    func bindItemSelected(output: BookMarkViewModel.Output) {
        collectionView.rx.itemSelected
            .withLatestFrom(output.dataSource){($0, $1)}
            .subscribe(onNext: { [weak self] (indexPath, dataSource) in
                
                guard let self else {return}
                
                let model = dataSource[indexPath.row]
                
                let vc = self.bookMarkDetailFactory.makeView(id: model.id)
                
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            
            })
            .disposed(by: disposeBag)
    }
    
    
}
