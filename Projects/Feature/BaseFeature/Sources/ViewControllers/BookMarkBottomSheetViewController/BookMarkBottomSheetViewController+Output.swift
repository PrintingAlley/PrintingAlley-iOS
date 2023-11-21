//
//  BookMarkBottomSheetViewController+Output.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 11/2/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import RxSwift


extension BookMarkBottomSheetViewController {
 
    func bindDataSource(output: BookMarkBottomSheetViewModel.Output) {
        
        output.dataSource
            .map{$0.bookmarkGroups}
            .bind(to: tableView.rx.items) { (tableView, index, model) -> UITableViewCell  in
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BookMarkListTableViewCell.identifier, for: indexPath) as? BookMarkListTableViewCell else {
                    return UITableViewCell()
                }
                
                cell.update(model: model)
                cell.selectionStyle = .none
                
                return cell
                
            }
            .disposed(by: disposeBag)
        
    }
    
    func bindResult(output: BookMarkBottomSheetViewModel.Output) {
        
        output.result
            .withUnretained(self)
            .subscribe(onNext: { (owner,result) in
                
                if result.statusCode == 400 {
                    owner.view.showBottomToast(text: "알 수 없는 에러가 발생 했습니다.")
                    owner.dismiss(animated: true)
                }
                
                else if result.statusCode == 401 {
                    owner.view.showBottomToast(text: result.message)
                    owner.dismiss(animated: true)
                }
                
                
            })
            .disposed(by: disposeBag)
        
    }
    
    func addResult(output: BookMarkBottomSheetViewModel.Output) {
        
        output.addResult
            .withUnretained(self)
            .subscribe(onNext: { (owner,result) in
                
                if result.statusCode != 400 && result.statusCode != 401 {
                    owner.dismiss(animated: true) {
                        owner.delegate?.success(id: result.dataId)
                    }
                    
                }
                
                else {
                    owner.view.showBottomToast(text: "알 수 없는 에러가 발생 했습니다.")
                }
                
                
            })
            .disposed(by: disposeBag)
        
    }
    
    
    
}
