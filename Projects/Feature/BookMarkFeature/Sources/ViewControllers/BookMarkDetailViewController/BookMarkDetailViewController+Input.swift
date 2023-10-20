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
}
