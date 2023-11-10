//
//  HomeViewController+Output.swift
//  HomeFeature
//
//  Created by yongbeomkwak on 11/7/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

extension HomeViewController {
    func bindDataSource(output: HomeViewModel.Output) {
        
        Observable.zip(output.tagDataSource,output.contentDataSource)
            .skip(1)
            .withUnretained(self)
            .subscribe(onNext: { (owner,dataSoruce) in
                
                owner.contentsCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
    }
}
