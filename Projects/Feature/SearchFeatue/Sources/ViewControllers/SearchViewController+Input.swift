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
        searchBar.searchTextField.rx.text.orEmpty
            .skip(1)
            .distinctUntilChanged()
            .bind(to: self.input.textString)
            .disposed(by: disposeBag)
    }
}
