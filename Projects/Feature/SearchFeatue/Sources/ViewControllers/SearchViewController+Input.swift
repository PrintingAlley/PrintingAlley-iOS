//
//  SearchViewController+Input.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import UtilityModule

extension SearchViewController {
    func bindUIEvent(input: SearchViewModel.Input) {
        let editingDidEnd = searchBar.searchTextField.rx.controlEvent(.editingDidEnd)
        let editingChanged = searchBar.searchTextField.rx.controlEvent(.editingChanged)
        
        searchBar.searchTextField.rx.text.orEmpty
            .skip(1)
            .distinctUntilChanged()
            .bind(to: self.input.textString)
            .disposed(by: disposeBag)
        
        editingChanged
            .subscribe(onNext: { [weak self] _ in
                guard let searchText = self?.searchBar.searchTextField.text else { return }
                guard let self = self else { return }
                
                if searchText.isEmpty {
//                    changeToBeforeVC()
                } else {
                    DEBUG_LOG("\(searchText)")
                }
            })
            .disposed(by: disposeBag)
        
        editingDidEnd
            .map { [weak self] in self?.searchBar.searchTextField.text ?? "" } // 텍스트 필드의 현재 텍스트 가져오기
            .subscribe(onNext: { [weak self] searchText in
                guard let self = self else { return }
                
                if searchText.isEmpty {
                    DEBUG_LOG("비었다~")
//                    changeToBeforeVC()
                } else {
//                    changeToAfterVC()
                    DEBUG_LOG("안 비었다: \(searchText)")
                }
            })
            .disposed(by: disposeBag)
    }
}
