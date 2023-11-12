//
//  BookMarkDetailViewController+Delegate.swift
//  BookMarkFeature
//
//  Created by yongbeomkwak on 11/11/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import BaseFeature
import DesignSystem

extension BookMarkDetailViewController: AutoHeightLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let product = output.dataSource.value.bookmarks[indexPath.row].product
        
        return CGFloat(product.height * 171 / product.width)
    }
}

extension BookMarkDetailViewController: PinterestCollectionViewCellDelegate {
    func remove(id: Int) {
        input.removeBookMark.onNext(id)
    }
    
}
