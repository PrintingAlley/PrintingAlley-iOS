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
import BaseFeatureInterface
import BaseDomainInterface

public protocol ProductDetailTableHeaderViewDelegate: AnyObject {
    func save(id: Int, isBookmarked: Bool)
    func move()
}


class ProductDetailTableHeaderView: UITableViewHeaderFooterView {

    static let identifer: String = "ProductDetailTableHeaderView"
    
    
    lazy var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumLineSpacing = .zero

    }
    
    lazy var carouselCountLabel: CarouselCountLabel = CarouselCountLabel()
    
    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.isPagingEnabled = true // 컨텐츠 만큼 스크롤
        $0.dataSource = self
        $0.delegate = self
        $0.register(ProductDetailHeaderCollectionViewCell.self, forCellWithReuseIdentifier: ProductDetailHeaderCollectionViewCell.identifer)
        $0.bounces = false
        $0.backgroundColor = .setColor(.sub(.white))
    }
    
    
    lazy var infoView: UIView = UIView().then {
        $0.backgroundColor = .setColor(.sub(.white))
    }
    
    lazy var titleLabel: AlleyLabel = AlleyLabel().then {
        $0.numberOfLines = 0
    }
    
    lazy var saveButton: UIButton = UIButton().then {
        $0.addTarget(self, action: #selector(save), for: .touchUpInside)
    }
    
    lazy var printShopLabel: AlleyLabel = AlleyLabel()
    
    lazy var movePrintShopButton: UIButton = UIButton().then {
        $0.addTarget(self, action: #selector(move), for: .touchUpInside)
    }
        
    lazy var designerLabel: AlleyLabel = AlleyLabel()
    
    lazy var emptyView: UIView = UIView().then {
        $0.backgroundColor = DesignSystemAsset.Grey.grey50.color
    }
    
    lazy var infoLabel: AlleyLabel = AlleyLabel("작품 상세정보", textColor: .sub(.black), font: .subtitle2)
    
    
    public weak var delegate: ProductDetailTableHeaderViewDelegate?
    
    var isSaved: Bool = false
    var model: ProductHeaderInfo = ProductHeaderInfo(id: 0, title: "", subtitle: "",printShop: PrintShopEntity.makeErrorEntity(),designer: "", images: [])
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .setColor(.sub(.white))
        addSubviews()
        makeConstraints()
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ProductDetailTableHeaderView {
    func addSubviews() {
        self.addSubviews(collectionView, infoView, emptyView, infoLabel, carouselCountLabel)
        self.infoView.addSubviews(titleLabel, saveButton, printShopLabel, designerLabel, movePrintShopButton )
    }
    
    func makeConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(390)
        }
        
        carouselCountLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(36)
            $0.bottom.equalTo(infoView.snp.top).offset(-31)
        }
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.left.right.equalToSuperview()

        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.left.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.right.equalToSuperview().inset(64)
        }
        
        saveButton.snp.makeConstraints {
            $0.width.equalTo(32)
            $0.height.equalTo(32)
            $0.right.equalToSuperview().inset(22)
            $0.top.equalTo(titleLabel.snp.top)

        }
        
        printShopLabel.snp.makeConstraints {
            $0.left.right.equalTo(HORIZON_MARGIN1())
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        
        designerLabel.snp.makeConstraints {
            $0.top.equalTo(printShopLabel.snp.bottom).offset(2)
            $0.left.right.equalTo(printShopLabel)
            $0.bottom.equalToSuperview().inset(21)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(infoView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(10)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(emptyView.snp.bottom).offset(17)
            $0.left.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        movePrintShopButton.snp.makeConstraints {
            $0.edges.equalTo(printShopLabel)
        }
    }
    
    @objc func save() {
        delegate?.save(id: model.id, isBookmarked: self.isSaved)
    }
    
    @objc func move() {
        delegate?.move()
    }
    
    func update(model: ProductHeaderInfo, isSaved: Bool) { 
        self.model = model
        self.isSaved = isSaved
        self.carouselCountLabel.setCount(1, model.images.count)
        titleLabel.setTitle(title: model.title, textColor: .sub(.black), font: .header3)
        
        printShopLabel.setMultipleAttributeText(text1: "담당 인쇄사  ", text2: model.printShop.name, color1: DesignSystemAsset.Grey.grey300.color, color2: DesignSystemAsset.MainBlue.blue500.color, font1: .subtitle3, font2: .subtitle3)
        
        designerLabel.setMultipleAttributeText(text1: "디자인  ", text2: model.designer, color1: DesignSystemAsset.Grey.grey300.color, color2: .black, font1: .subtitle3, font2: .body2)
        
        
        saveButton.setImage(isSaved ? DesignSystemAsset.Icon.blueBookMark.image : DesignSystemAsset.Icon.emptyBookMark.image, for: .normal)
        
        collectionView.reloadData()
    }
    

}


extension ProductDetailTableHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailHeaderCollectionViewCell.identifer, for: indexPath) as? ProductDetailHeaderCollectionViewCell else  {
            return UICollectionViewCell()
        }
        
        cell.update(image: model.images[indexPath.row])
        return cell
    }
    
    
}

extension ProductDetailTableHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: APP_WIDTH(), height: 390)
    }
}

extension ProductDetailTableHeaderView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let i = Int(scrollView.contentOffset.x / APP_WIDTH())

        self.carouselCountLabel.setCount(i+1, model.images.count)
    }
}
