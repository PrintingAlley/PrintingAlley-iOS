//
//  CategorySearchViewController+Delegate.swift
//  CategorySearchFeatureDemo
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule

extension CategorySearchViewController: CategoryEmptyHeaderViewDelegate {
    func press() {
        DEBUG_LOG("초기화")
    }

}

extension CategorySearchViewController: FilterViewControllerDelegate {
    func receive(result: [Int]) {
        DEBUG_LOG("RESULT: \(result)")
    }
}
