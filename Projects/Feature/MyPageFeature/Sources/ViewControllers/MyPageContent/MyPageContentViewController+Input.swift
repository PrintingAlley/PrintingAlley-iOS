//
//  MyPageContentViewController+Input.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import RxCocoa

extension MyPageContentViewController {
    
    func bindPreference() {
        PreferenceManager
            .$user
            .withUnretained(self)
            .subscribe(onNext: { (owner,user)  in
                guard let user = user else { return }
                
                owner.profileLabel.setTitle(title: user.name, textColor: .sub(.black), font: .subtitle1)
            })
            .disposed(by: disposeBag)
    }
    
    func bindEditName() {
        profileNameEditButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe(onNext: { (owner, _ ) in
                
                let vc = owner.editModalFactory.makeView(id: -1, type: .reNameprofileName)
                
                vc.modalPresentationStyle = .overFullScreen
                
                owner.present(vc, animated: false)
                
            })
            .disposed(by: disposeBag)
    }
    
}
