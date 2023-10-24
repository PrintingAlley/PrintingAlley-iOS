//
//  SearchViewController+Output.swift
//  SearchFeatueDemo
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import RxSwift
import UIKit
import UtilityModule

extension SearchViewController {
    func bindTagDataSource(output: SearchViewModel.Output) {

             output.searchDataSource
                 .debug("검색뷰")
                 .subscribe(onNext: {
                     DEBUG_LOG($0)
                 })
                 .disposed(by: disposeBag)
         }
}
