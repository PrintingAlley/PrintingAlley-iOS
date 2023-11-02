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
import BaseDomainInterface

extension CategorySearchViewController: CategoryEmptyHeaderViewDelegate {
    func press() {
        DEBUG_LOG("초기화")
    }

}

extension CategorySearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            let tempLabel = AlleyLabel(filterTags[indexPath.row].name, font: .body1).then {
                $0.sizeToFit()
            }
            return CGSize(width: tempLabel.frame.width + 20 + 28, height: tempLabel.frame.height + 8)
        
        default:
            return CGSize(width: 70, height: 70)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        filterTags.remove(at: indexPath.row)
        DEBUG_LOG(filterTags)
        collectionView.reloadData()
    }
}

extension CategorySearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return filterTags.count

        case 1:
            return dummy.count

        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath) as? FilterButtonCollectionViewCell else {
                return UICollectionViewCell()
            }
            let tmpChildrenTagEntity = ChildrenTagEntity(id: filterTags[indexPath.row].id, name: filterTags[indexPath.row].name, image: "", parentID: 0, children: [])
            cell.update(model: tmpChildrenTagEntity, type: .selectedWithX, willChangeUI: false)
            return cell

        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCollectionViewCell.identifer, for: indexPath) as? PinterestCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.update(model: dummy[indexPath.row])
            return cell

        default:
            return UICollectionViewCell()
        }
    }
}

extension CategorySearchViewController: AutoHeightLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        return dummy[indexPath.row].image.size.height
        // 이미지 height 넘겨주면 됨
    }
}
