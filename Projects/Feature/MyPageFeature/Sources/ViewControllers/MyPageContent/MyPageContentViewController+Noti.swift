//
//  MyPageContentViewController+Noti.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

extension MyPageContentViewController {
    func bindRefresh(input: MyPageContentViewModel.Input) {
        NotificationCenter.default.rx
            .notification(.refreshUserInfo)
            .map{_ in ()}
            .bind(to: input.fetchUserInfo)
            .disposed(by: disposeBag)
    }
}
