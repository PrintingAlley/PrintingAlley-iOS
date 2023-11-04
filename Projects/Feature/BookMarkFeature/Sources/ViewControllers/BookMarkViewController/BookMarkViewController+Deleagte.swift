//
//  BookMarkViewController+Deleagte.swift
//  BookMarkFeature
//
//  Created by yongbeomkwak on 11/3/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit

extension BookMarkViewController: BookMarkCollectionViewCellDelegate {
    func tapBookMark(id: Int) {
        input.tapItem.onNext(id)
    }

}
