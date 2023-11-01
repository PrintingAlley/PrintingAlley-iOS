//
//  CategorySearchViewController+Delegate.swift
//  CategorySearchFeatureDemo
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import UtilityModule
import UIKit
import BaseFeature
import DesignSystem

extension CategorySearchViewController: CategoryEmptyHeaderViewDelegate {
    func press() {
        DEBUG_LOG("초기화")
    }

}

extension CategorySearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCollectionViewCell.identifer, for: indexPath) as? PinterestCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.update(model: dummy[indexPath.row])
        return cell
    }
}

extension CategorySearchViewController: AutoHeightLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return dummy[indexPath.row].image.size.height
        // 이미지 height 넘겨주면 됨
    }
}
