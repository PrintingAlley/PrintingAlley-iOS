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
    
    /// DataSource 바인딩
    func bindDataSource(input: BookMarkViewModel.Input, output: BookMarkViewModel.Output) {
        
        output.dataSource
            .do(onNext: { [weak self] _ in
                guard let self else {return}
                self.indicator.stopAnimating()
            })
            .bind(to: tableView.rx.items) { (tableView, index, model) -> UITableViewCell in
                
                let indexPath: IndexPath = IndexPath(row: index, section: 0)
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: BookMarkTableViewCell.identifier, for: indexPath) as? BookMarkTableViewCell  else {
                    return UITableViewCell()
                }
                
                cell.deleagte = self
                cell.selectionStyle = .none
                cell.update(model: model,isEditing: input.isEdit.value , isLast: output.dataSource.value.count-1 == index )
                
                return cell
            }
        
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: {
                
                print($0)
            })
            .disposed(by: disposeBag)
        
    }
    
    /// 뒤로가기 버튼
    func bindBackButton() {
        backButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                
                self?.navigationController?.popViewController(animated: true)
                
            })
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
        tableView.rx.itemSelected
            .withLatestFrom(output.dataSource){($0, $1)}
            .subscribe(onNext: { [weak self] (indexPath, dataSource) in
                
                guard let self else {return}
                
                let model = dataSource[indexPath.row]
                
                let vc = self.bookMarkDetailFactory.makeView()
                
            
            })
            .disposed(by: disposeBag)
    }
    
    
}
