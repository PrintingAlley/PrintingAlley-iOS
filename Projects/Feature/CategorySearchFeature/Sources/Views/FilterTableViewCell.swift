//
//  FillterTableViewCell.swift
//  HomeFeatureDemo
//
//  Created by yongbeomkwak on 10/25/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import BaseDomainInterface
import BaseFeature
import UtilityModule


class FilterTableViewCell: UITableViewCell {

    
    public static let identifier = "FirstFillterTableViewCell"
    
    var preTags: Set<Tag> = .init()
    
    lazy var layout = LeftAlignedCollectionViewFlowLayout().then{
        $0.minimumLineSpacing = 8
        $0.minimumInteritemSpacing = 6
    }
    
    
    lazy var collectionView: UICollectionView = makeCollectionView(layout: layout, scrollDirection: .vertical).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
        $0.bounces = false
        $0.isScrollEnabled = false
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false 
    }
    
   

    var items:[ChildrenTagEntity] = []

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .setColor(.sub(.white))
        addSubviews()
        makeConstraints()
        
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension FilterTableViewCell {
    
    func makeCollectionView(layout: UICollectionViewFlowLayout, scrollDirection: UICollectionView.ScrollDirection) -> UICollectionView {
        layout.scrollDirection = scrollDirection
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.delegate = self
            $0.dataSource = self
        }
        return collectionView
    }
    
    func addSubviews() {
        self.contentView.addSubviews(collectionView)
    }
    
    func makeConstraints() {
    
        collectionView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(24)
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    func update(model: ChildrenTagEntity, preTags: Set<Tag>) {
        self.items = model.children.filter({$0.children.isEmpty}) // 2,3층 상관 없이 최종 계층은 children이 비어있으
        self.preTags = preTags
        collectionView.reloadData()
    }
}


extension FilterTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: 0.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        let tempLabel = AlleyLabel(items[indexPath.row].name, font: .subtitle2).then {
            $0.sizeToFit()
        }
        
  
        return CGSize(width: tempLabel.frame.width+20, height: tempLabel.frame.height + 8)
    }

}

extension FilterTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath)
                as? FilterButtonCollectionViewCell else {
            
            return UICollectionViewCell()
            
        }
        
        let model = items[indexPath.row]
        
    
        cell.update(model: model, type: .basic, willChangeUI: true, preSelected: preTags.contains(Tag(name: model.name, id: model.id)))
    
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return items.count
    }
    
    

}


