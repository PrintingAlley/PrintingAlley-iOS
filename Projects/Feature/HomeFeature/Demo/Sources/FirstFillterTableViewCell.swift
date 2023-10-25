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

class FirstFillterTableViewCell: UITableViewCell {

    
    public static let identifier = "FirstFillterTableViewCell"
    
    lazy var collectionView: UICollectionView = makeCollectionView(layout: LeftAlignedCollectionViewFlowLayout(), scrollDirection: .horizontal).then {
        $0.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
    }
    
    var model:ChildrenTagEntity = ChildrenTagEntity(id: 0, name: "", image: "", parentID: 0, children: [])
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension FirstFillterTableViewCell {
    
    func makeCollectionView(layout: UICollectionViewFlowLayout, scrollDirection: UICollectionView.ScrollDirection) -> UICollectionView {
        layout.scrollDirection = scrollDirection
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.delegate = self
            $0.dataSource = self
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        return collectionView
    }
    
    func addSubviews() {
        self.contentView.addSubviews(collectionView)
    }
    
    func makeConstraints() {

        
        collectionView.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(24)
            $0.top.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    func update(model: ChildrenTagEntity) {
        self.model = model
        
        print("FIRST \(model)")
        
        collectionView.reloadData()
    }
}

extension FirstFillterTableViewCell : UICollectionViewDelegate {
    
}


extension FirstFillterTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        let tempLabel = AlleyLabel(model.children[indexPath.row].name, font: .body1).then {
            $0.sizeToFit()
        }
        return CGSize(width: tempLabel.frame.width + 20, height: tempLabel.frame.height + 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
}

extension FirstFillterTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.children.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath)
                as? FilterButtonCollectionViewCell else { return UICollectionViewCell() }
        cell.update(model: model.children[indexPath.row], type: .basic, willChangeUI: true)
        return cell
    }

}
