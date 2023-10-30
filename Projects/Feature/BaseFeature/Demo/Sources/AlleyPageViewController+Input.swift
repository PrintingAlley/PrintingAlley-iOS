//
//  AlleyPageViewController+Input.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension AlleyPageViewController {
    
    
    

    func bindCollectionEvent() {
        
        collectionView
            .rx
            .itemSelected
            .map{$0.row}
            .withLatestFrom(input.selectedIndex){($0,$1)}
            .do(onNext: { [weak self] (prev,curr) in
                
                guard let self else {return}
                
                
                self.pageViewController.setViewControllers([self.viewControllers[curr]], direction:  prev < curr ? .forward : .reverse, animated: true, completion: nil)
                
                
            })
            .map{$0.1}
            .bind(to: input.selectedIndex)
            .disposed(by: disposeBag)
        
    }
    
}
