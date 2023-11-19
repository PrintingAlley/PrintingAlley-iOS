//
//  CategorySearchViewController+Delegate.swift
//  CategorySearchFeatureDemo
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import BaseFeature
import DesignSystem
import BaseDomainInterface
import UtilityModule

extension CategorySearchViewController: CategoryEmptyHeaderViewDelegate {
    func press() {
        DEBUG_LOG("초기화")
        output.tags.accept([])
        input.pageID.accept(1)
        gridCollectionView .setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        input.isFetchByScroll.accept(false)
        filterCollectionView.reloadData()
    }

}

extension CategorySearchViewController: FilterViewControllerDelegate {
    func receive(result: [Tag]) {
        DEBUG_LOG("RESULT: \(result)")
        output.tags.accept(result)
        input.pageID.accept(1)
        gridCollectionView .setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        input.isFetchByScroll.accept(false)
        filterCollectionView.reloadData()
    }
}

extension CategorySearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            let tempLabel = AlleyLabel(output.tags.value[indexPath.row].name, font: .body1).then {
                $0.sizeToFit()
            }
            return CGSize(width: tempLabel.frame.width + 20 + 28, height: tempLabel.frame.height + 8)
        
        default:
            return CGSize(width: 70, height: 70)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5 // filterCollectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var tags = output.tags.value
        
        if collectionView.tag == 0 {
            tags.remove(at: indexPath.row)
            output.tags.accept(tags)
            input.pageID.accept(1)
            gridCollectionView .setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            input.isFetchByScroll.accept(false)
            filterCollectionView.reloadData()
        }
    }
}

extension CategorySearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return output.tags.value.count

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
            
            let tags = output.tags.value
            let tmpChildrenTagEntity = ChildrenTagEntity(id: tags[indexPath.row].id, name: tags[indexPath.row].name, image: "", parentID: 0, children: [])
            cell.update(model: tmpChildrenTagEntity, type: .selectedWithX, willChangeUI: false)
            return cell

        default:
            return UICollectionViewCell()
        }
    }
}

extension CategorySearchViewController: AutoHeightLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let product = output.dataSource.value[indexPath.row]
        
        return CGFloat(product.height * 171 / product.width)
    }
}
