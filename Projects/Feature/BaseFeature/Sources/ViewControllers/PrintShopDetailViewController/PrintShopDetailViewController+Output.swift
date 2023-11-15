//
//  PrintShopDetailViewController+Output.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/15.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation

extension PrintShopDetailViewController {
    func bindDataSource(output: PrintShopDetailViewModel.Output) {
        output.dataSource
            .skip(1)
            .subscribe(onNext: { [weak self] dataSource in
                guard let self else { return }
                
                update(model: dataSource)
            })
            .disposed(by: disposeBag)
    }
}
