//
//  HomeViewController+Deleagte.swift
//  HomeFeature
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import UtilityModule

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        return CGSize(width: (APP_WIDTH() - contentsInsets.left - contentsInsets.right - contentsCellSpacing) / 2, height: 201)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 줄 간격
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 옆 간격
        return contentsCellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContentsHeaderView.identifier, for: indexPath) as! ContentsHeaderView
            
            headerView.update(tagDataSource: output.tagDataSource.value)
            headerView.delgate = self
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // 헤더 뷰의 크기 반환
        return CGSize(width: APP_WIDTH(), height: headerViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        contentsInsets
    }
}


extension HomeViewController: ContentsHeaderViewDelegate {
    func categoryTap(id: Int, title: String) {
        self.navigationController?.pushViewController(categorySearchFactory.makeView(id: id, title: title), animated: true)
    }
}
