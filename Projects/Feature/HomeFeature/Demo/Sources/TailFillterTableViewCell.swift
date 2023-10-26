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

public protocol TailFillterTableViewCellDelegate : AnyObject {
    func press(id: Int)
}

class TailFillterTableViewCell: UITableViewCell {

    
    public static let identifier = "FirstFillterTableViewCell"
    
//    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
//        $0.scrollDirection = .vertical
//        
//    }
    
    
    lazy var collectionView: UICollectionView = makeCollectionView(layout: LeftAlignedCollectionViewFlowLayout(), scrollDirection: .vertical).then {
        $0.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
    }
    
   
    
    var model:ChildrenTagEntity = ChildrenTagEntity(id: 0, name: "", image: "", parentID: 0, children: [])
    
    
    public weak var delegate: TailFillterTableViewCellDelegate?
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeConstraints()
        
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension TailFillterTableViewCell {
    
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
    
    func update(model: ChildrenTagEntity) {
        self.model = model

        
        collectionView.reloadData()
    }
}



extension TailFillterTableViewCell: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsets(top: 0, left: 0.0, bottom: 0, right: .zero)
//    }
    
    
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { //셀 층간의 간격 (세로)
        8
    }
    

}

extension TailFillterTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath)
                as? FilterButtonCollectionViewCell else {
            
            return UICollectionViewCell()
            
        }

        cell.update(model: model.children[indexPath.row], type: .basic, willChangeUI: true)
        cell.delegate = self

        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
            return model.children.count
    }
    
    

}


extension TailFillterTableViewCell : FilterButtonCollectionViewCellDelegate {
    func press(id: Int) {
        delegate?.press(id: id)
    }
    
}
