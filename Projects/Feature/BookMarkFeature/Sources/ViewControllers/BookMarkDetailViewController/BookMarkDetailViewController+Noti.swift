//
//  BookMarkDetailViewController+Noti.swift
//  BookMarkFeature
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


extension BookMarkDetailViewController {
    // 리프래시 바인딩
    func bindRefresh(input: BookMarkDetailViewModel.Input) {
        
        NotificationCenter.default.rx.notification(.refreshBookMark)
            .map{_ in ()}
            .bind(to: input.fetchDataSource)
            .disposed(by: disposeBag)
    }
    
}
