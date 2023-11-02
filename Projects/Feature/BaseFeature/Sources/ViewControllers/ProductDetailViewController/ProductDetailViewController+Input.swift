//
//  ProductDetailViewController+Input.swift
//  BaseFeature
//
//  Created by yongbeomkwak on 11/2/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift

extension ProductDetailViewController {
    func bindFetchData() {
        input.fetchData.onNext(())
    }
}
