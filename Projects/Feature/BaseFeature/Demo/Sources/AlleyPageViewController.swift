//
//  AlleyPageViewController.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 10/29/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import SnapKit
import Then

class AlleyPageViewController: UIViewController {

    
    private var viewControllers: [UIViewController] = []
    private var titles:[String] = []

    lazy var layer: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero
        $0.estimatedItemSize = .zero
    }
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layer).then {
        $0.bounces = false
        $0.register(PageTitleCollectionViewCell.self, forCellWithReuseIdentifier: PageTitleCollectionViewCell.identifer)
        $0.delegate = self
        $0.dataSource = self
    }
    
    lazy var baseLine: UIView = UIView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    lazy var containerView: UIView = UIView().then {
        $0.backgroundColor = .red
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeConstraints()
        configureCommonUI()
    }
    

}

extension AlleyPageViewController {
    
    public func setTitle(_ titles:[String]) {
        self.titles = titles
    }
    
    public func setChildren(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        
        //view.layoutIfNeeded()
       
    }
    
    func addSubviews() {
        self.view.addSubviews(collectionView,baseLine,containerView)
    }
    
    func makeConstraints() {
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
        }
        
        baseLine.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.top.equalTo(collectionView.snp.bottom)
        }
        
        containerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(baseLine.snp.bottom)
            //$0.height.equalTo(56)
        }
        
    }
    
}


extension AlleyPageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / CGFloat(titles.count)
           return CGSize(width: width, height: 56)
       }
    

}


extension AlleyPageViewController: UICollectionViewDelegate {

}

extension AlleyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageTitleCollectionViewCell.identifer, for: indexPath) as? PageTitleCollectionViewCell else  {
            return UICollectionViewCell()
        }
        
        cell.update(title: titles[indexPath.row])
        cell.backgroundColor = .blue
        return cell
    }
        
    

}
