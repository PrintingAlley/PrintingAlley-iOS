//
//  AlleyPageViewController+Delegate.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit



extension AlleyPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        
        if let currentViewController = pageViewController.viewControllers?.first,
                let currentIndex = viewControllers.firstIndex(of: currentViewController) {
                 // currentIndex가 현재 선택된 페이지의 인덱스입니다.
                input.selectedIndex.accept(currentIndex)
        }
        
    }
}

extension AlleyPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(viewModel.titles.count)
        
           return CGSize(width: width, height: 58)
       }
}

extension AlleyPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.reloadData()
    }
}
