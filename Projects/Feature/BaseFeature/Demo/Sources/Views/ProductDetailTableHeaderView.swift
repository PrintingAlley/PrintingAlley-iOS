//
//  d.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import UtilityModule
import SnapKit
import Then

public protocol ProductDetailTableHeaderViewDelegate: AnyObject {
    func save(id: Int, isBookmarked: Bool)
}


class ProductDetailTableHeaderView: UITableViewHeaderFooterView {

    static let identifer: String = "ProductDetailTableHeaderView"
    
    private let dummyImages: [String] = ["https://ibb.co/T0Gy2p3","https://ibb.co/T0Gy2p3","https://ibb.co/T0Gy2p3"]
    
    lazy var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero

    }
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.isPagingEnabled = true // 컨텐츠 만큼 스크롤
        $0.dataSource = self
        $0.delegate = self
        $0.register(ProductDetailHeaderCollectionViewCell.self, forCellWithReuseIdentifier: ProductDetailHeaderCollectionViewCell.identifer)
        $0.bounces = false
    }
    
    
    lazy var infoView: UIView = UIView()
    
    lazy var titleLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 1
    }
    lazy var subtitleLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 1
    }
    
    lazy var saveButton: UIButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.blueBookMark.image, for: .normal)
    }
    
    lazy var emptyView: UIView = UIView().then {
        $0.backgroundColor = colorFromRGB("E7E8EE")
    }
    
    
    public weak var delegate: ProductDetailTableHeaderViewDelegate?
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubviews()
        makeConstraints()
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ProductDetailTableHeaderView {
    func addSubviews() {
        self.addSubviews(collectionView, infoView,saveButton, emptyView)
        self.infoView.addSubviews(titleLabel, subtitleLabel)
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(390)
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.left.equalToSuperview().inset(21)
            $0.right.equalToSuperview().inset(64)
            
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24)
            $0.left.right.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.left.right.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.bottom.equalToSuperview().inset(22)
        }
        
        saveButton.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(32)
            $0.right.equalToSuperview().inset(22)
            $0.top.equalTo(titleLabel.snp.top)

        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(10)
        }
    }
    
    @objc func save() {
        delegate?.save(id: 0, isBookmarked: false)
    }
    
    func update() {
        titleLabel.setTitle(title: "아아라라라", textColor: .sub(.black), font: .header3)
        subtitleLabel.setTitle(title: "명함", textColor: .grey(.grey100), font: .subtitle3)
    }
    

}


extension ProductDetailTableHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailHeaderCollectionViewCell.identifer, for: indexPath) as? ProductDetailHeaderCollectionViewCell else  {
            return UICollectionViewCell()
        }
        
        cell.update(image: dummyImages[indexPath.row])
        return cell
    }
    
    
}

extension ProductDetailTableHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: APP_WIDTH(), height: 390)
    }
}
