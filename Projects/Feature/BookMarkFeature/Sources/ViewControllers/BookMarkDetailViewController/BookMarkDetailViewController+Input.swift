//
//  BookMarkDetailViewController+Input.swift
//  BookMarkFeature
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import RxSwift
import RxDataSources
import UtilityModule


extension BookMarkDetailViewController {
    
    func bindViewDidLoad(input: BookMarkDetailViewModel.Input) {
       input.fetchDataSource.onNext(())
        
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
    
    func bindEditButton() {
        editButton.rx
            .tap
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in
                
                let vc = owner.editModalFactory.makeView(id:owner.viewModel.bookMarkGroupId, title: "저장목록 이름 수정", type: .reNameBookMark)
                
                vc.modalPresentationStyle = .overFullScreen
                
                owner.present(vc, animated: false)
                
            })
            .disposed(by: disposeBag)
            
    }
}
