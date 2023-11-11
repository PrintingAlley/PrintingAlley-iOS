//
//  AlleyPageViewController+DataSource.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit


extension AlleyPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        /// viewControllerBefore: 왼쪽에서 오른쪽으로 스와이프 하기 직전에 호출 > 직전에 다음 화면에 어떤 ViewController가 표출될지 결정 ,  이전으로가기

        guard let index = viewControllers.firstIndex(of: viewController) else {return nil}
        
        let previousIndex = index - 1
        
        if previousIndex < 0 {
            return nil
        }
        
        return viewControllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        /// viewControllerAfter: 오른쪽에서 왼쪽으로 스와이프 하기 직전에 호출 > 직전에 다음 화면에 어떤 ViewController가 표출될지 결정 , 오른쪽으로가기
        ///
        
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == viewControllers.count {
            return nil
        }
        return viewControllers[nextIndex]
   
    }
    

//    // 인디케이터 개수
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return self.viewControllers.count
//    }
//    
//    // 인디케이터 초기 선택 값
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return input.selectedIndex.value
//    }
    
    
}


extension AlleyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageTitleCollectionViewCell.identifer, for: indexPath) as? PageTitleCollectionViewCell else  {
            return UICollectionViewCell()
        }
        
        cell.update(title: viewModel.titles[indexPath.row], isSelectedIndex: indexPath.row == input.selectedIndex.value)
        return cell
    }
        
    

}
