//
//  MyPageContentViewController+Output.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule

extension MyPageContentViewController {
    
    func bindUserInfo(output: MyPageContentViewModel.Output) {
        
        output
            .userData
            .subscribe(onNext: { user in
                PreferenceManager.shared.setUserInfo(id: user.id, name: user.name, profileImage: user.profileImage, email: user.email, platform: .init(rawValue: user.provider) ?? .apple)
                
            })
            .disposed(by: disposeBag)
    }
    
    func bindShowToast(output: MyPageContentViewModel.Output) {
        output.showToast
            .withUnretained(self)
            .subscribe(onNext: { (owner,result) in
                
                owner.view.showBottomToast(text: result.message)
                
                //LOGOUT()
                
            })
            .disposed(by: disposeBag)
    }
}
