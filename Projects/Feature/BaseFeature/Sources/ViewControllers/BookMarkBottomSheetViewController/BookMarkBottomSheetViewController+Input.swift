//
//  BookMarkBottomSheetViewController+Input.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 11/2/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import UtilityModule
 
extension BookMarkBottomSheetViewController {
    
    func bindFetchData(input: BookMarkBottomSheetViewModel.Input) {
        
        NotificationCenter.default.rx
            .notification(.refreshBookMarkGroup)
            .map{_ in ()}
            .bind(to: input.fetchData)
            .disposed(by: disposeBag)
        
        
    }
    
    func bindtapItem(input: BookMarkBottomSheetViewModel.Input) {
        
        tableView.rx
            .itemSelected
            .map{$0.row}
            .bind(to: input.selectedItem)
            .disposed(by: disposeBag)
    }
    
    
    
}
