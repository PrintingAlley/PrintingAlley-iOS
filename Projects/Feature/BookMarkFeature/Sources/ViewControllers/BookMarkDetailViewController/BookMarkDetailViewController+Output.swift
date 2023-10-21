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

extension BookMarkDetailViewController {
    func bindDataSource(input: BookMarkDetailViewModel.Input, output: BookMarkDetailViewModel.Output) {
        
        output.dataSource
            .do(onNext: { [weak self] dataSource in
                
                guard let self else {return}
                
                self.tableView.tableHeaderView = dataSource.bookmarks.isEmpty ? emptyHeaderView : nil
                self.naviTitleLabel.setTitle(title: dataSource.name, textColor: .sub(.black), font: .header3,alignment: .center)
                
                self.countLabel.setTitle(title: "장소 \(dataSource.bookmarks.count)개", textColor: .grey(.grey400), font: .caption1,alignment: .center)
                
            })
            .map({$0.bookmarks})
            .bind(to: tableView.rx.items) { [weak self] (tableView, index, model) -> UITableViewCell in
                
                guard let self else { return UITableViewCell() }
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BookMarkDetailTableViewCell.identifier, for: indexPath) as? BookMarkDetailTableViewCell  else {
                    return UITableViewCell()
                }
                
                cell.deleagte = self
                cell.selectionStyle = .none
                cell.update(model: model, isLast: output.dataSource.value.bookmarks.count-1 == index)
                
                return cell
            }
        
            .disposed(by: disposeBag)
        
    }
    
    func bindItemSelected(output: BookMarkDetailViewModel.Output) {
        tableView.rx.itemSelected
            .subscribe(onNext: {
                
                print($0)
            })
            .disposed(by: disposeBag)
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
