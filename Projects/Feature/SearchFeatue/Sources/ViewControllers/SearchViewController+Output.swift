//
//  SearchViewController+Output.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/10/23.
//  Copyright © 2023 com. All rights reserved.
//

import RxSwift
import UIKit
import UtilityModule

extension SearchViewController { // TODO: - 텍스트로 검색 결과 데이터 소스 받아오기
    func bindDataSource(input: SearchViewModel.Input, output: SearchViewModel.Output) {
        output.dataSource
            .do(onNext: { datasource in
                print("\(datasource)")
            })
//            .disposed(by: disposeBag)
    }
}
