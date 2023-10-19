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

extension BookMarkViewController {
    
    func bindDataSource(input: BookMarkViewModel.Input, output: BookMarkViewModel.Output) {
        
        output.dataSource
            .bind(to: tableView.rx.items) { (tableView, index, model) -> UITableViewCell in
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BookMarkTableViewCell.identifier, for: indexPath) as? BookMarkTableViewCell  else {
                    return UITableViewCell()
                }
                
                cell.deleagte = self
                cell.selectionStyle = .none
                cell.update(model: model,index: index, isEditing: input.isEdit.value , isLast: output.dataSource.value.count-1 == index )
                
                return cell
            }
        
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: {
                
                print($0)
            })
            .disposed(by: disposeBag)
        
    }
    
    func bindBackButton() {
        backButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                
                self?.navigationController?.popViewController(animated: true)
                
            })
            .disposed(by: disposeBag)
    }
    
    func bindIndexOfSelectedItem(output: BookMarkViewModel.Output) {
        
        output.indexOfSelectedItem
            .asDriver()
            .drive(onNext:{ [weak self] selectedIndex in
                
                guard let self else {return}
                
                self.deleteButton.isEnabled = !selectedIndex.isEmpty
                
                // 선택된게 비어있으면 삭제는 비활성 화
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func bindRefresh(input: BookMarkViewModel.Input) {
        
        NotificationCenter.default.rx.notification(.refreshBookMark)
            .map{_ in ()}
            .bind(to: input.fetchDataSource)
            .disposed(by: disposeBag)
    }
    
}
