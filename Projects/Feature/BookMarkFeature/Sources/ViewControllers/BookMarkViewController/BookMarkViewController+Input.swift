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
        input.fetchDataSource.onNext(())
    }
    
    /// refreshEvent
    func bindRefreshControl(input: BookMarkViewModel.Input) {
        refreshControl.rx
            .controlEvent(.valueChanged)
            .bind(to: input.fetchDataSource)
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
    
    // 편집 및 완료 버튼
    func bindStateInputWithButton(input: BookMarkViewModel.Input) {
        
        editOrDoneButton.rx
            .tap
            .bind(to: input.tapStateButton)
            .disposed(by: disposeBag)
        
    }
    
    // 편집 상태 별 상태 변화
    func bindEditState(input: BookMarkViewModel.Input) {
        
        input.isEdit
            .asDriver()
            .drive(onNext: { [weak self] isEdit  in
            
            guard let self else {return}
            
            self.backButton.isHidden = isEdit
            self.deleteButton.isHidden = !isEdit
            
            self.editOrDoneButton.setTitle(isEdit ? "완료" : "편집", for: .normal)
            self.editOrDoneButton.titleLabel?.font = .setFont(.body1)
                self.editOrDoneButton.setTitleColor(isEdit ? DesignSystemAsset.MainBlue.blue500.color : DesignSystemAsset.MainBlue.blue500.color, for: .normal)
            
        })
        .disposed(by: disposeBag)
        
    }
    
 
    /// 삭제버튼 이벤트 바인딩
    func bindTapDelete(input: BookMarkViewModel.Input) {
        deleteButton.rx
            .tap
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in
                
                let vc = AlertViewController(title: "저장목록을 삭제하시겠어요?", content: "목록을 삭제하면 저장된 장소도\n함께 사라져요.", type: .delete,  completion: {
                    input.runDelete.onNext(())
                })
                vc.modalPresentationStyle = .overFullScreen
                owner.present(vc,animated: false)
                
            })
            .disposed(by: disposeBag)
    }
    

}
