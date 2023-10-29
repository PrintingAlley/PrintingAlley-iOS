//
//  PrintShopDetailViewController.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/29/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import UtilityModule
import DesignSystem

class PrintShopDetailViewController: UIViewController {

    lazy var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
    }
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {_ in 
        //$0.dataSource = self
       // $0.delegate = self
    }
    
        
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

}


extension PrintShopDetailViewController {
    func addSubviews() {
        self.view.addSubviews(collectionView)
    }
}

//
//extension PrintShopDetailViewController: UICollectionViewDelegate {
//    
//}
//
//extension PrintShopDetailViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//    }
//    
//    
//}
