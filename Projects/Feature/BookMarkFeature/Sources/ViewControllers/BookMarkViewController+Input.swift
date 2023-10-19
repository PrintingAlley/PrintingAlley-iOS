//
//  BookMarkViewController+Input.swift
//  BookMarkFeature
//
//  Created by yongbeomkwak on 10/18/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import DesignSystem
import UIKit

extension BookMarkViewController {
    
    func bindViewDidLoad(input: BookMarkViewModel.Input) {
        input.viewDidLoad.onNext(())
    }
    
    func bindStateInputWithButton(input: BookMarkViewModel.Input) {
        
        editOrDoneButton.rx
            .tap
            .bind(to: input.tapStateButton)
            .disposed(by: disposeBag)
        
    }
    
    func bindEditState(input: BookMarkViewModel.Input) {
        
        input.isEdit
            .subscribe(onNext: { [weak self] _  in
                
                guard let self else {return}
                
                guard let vc = self.baseFactory.makeEditModal(title: "생성", type: .newBookMark) as? UIViewController else {
                    return
                }
                vc.modalPresentationStyle = .overFullScreen
                
                self.present(vc, animated: false)
            })
//            .asDriver()
//            .drive(onNext: { [weak self] isEdit  in
//            
//            guard let self else {return}
//            
//            self.backButton.isHidden = isEdit
//            self.deleteButton.isHidden = !isEdit
//            
//            self.editOrDoneButton.setTitle(isEdit ? "완료" : "편집", for: .normal)
//            self.editOrDoneButton.titleLabel?.font = .setFont(.body1)
//            self.editOrDoneButton.setTitleColor(isEdit ? DesignSystemAsset.MainBlue.blue500.color : .black, for: .normal)
//            
//        })
        .disposed(by: disposeBag)
        
    }
}
