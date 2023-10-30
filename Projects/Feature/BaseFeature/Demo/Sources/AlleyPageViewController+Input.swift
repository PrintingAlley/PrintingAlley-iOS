//
//  AlleyPageViewController+Input.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/30/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation


extension AlleyPageViewController {
    
    
    

    func bindCollectionEvent() {
        
        collectionView
            .rx
            .itemSelected
            .map{$0.row}
            .bind(to: input.selectedIndex)
            .disposed(by: disposeBag)
        
    }
    
}
