//
//  PinterestCollectionViewCell.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/10/31.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import UtilityModule
import BaseDomainInterface
import Kingfisher

public protocol PinterestCollectionViewCellDelegate: AnyObject {
    func remove(id:Int)
}



public final class PinterestCollectionViewCell: UICollectionViewCell {
    
    public static let identifer = "PinterestCollectionViewCell"
    
    public weak var delegate: PinterestCollectionViewCellDelegate?
    var id: Int!
    
    public var imageView = UIImageView().then {
        $0.setRound([.allCorners], radius: RADIUS1())
        $0.contentMode = .scaleAspectFit
    }
    
    public var imageHeight: CGFloat = 171
    
    public var title = AlleyLabel("Print Alley", textColor: .sub(.black), font: .body2).then {
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    public lazy var bookmarkButton = UIButton().then { // 필요할 때 isHidden 시키기
        $0.setImage(DesignSystemAsset.Icon.blueBookMark.image, for: .normal)
        $0.setImage(DesignSystemAsset.Icon.emptyBookMark.image, for: .selected)
        $0.addTarget(self, action: #selector(touchUpBookmark), for: .touchUpInside)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI 관련 함수
extension PinterestCollectionViewCell {
    
    private func addSubviews() {
        contentView.addSubviews(imageView, title, bookmarkButton)
    }
    
    private func makeConstrains() {
        imageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(171)
            $0.height.equalTo(171)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.leading.equalTo(imageView)
            $0.width.equalTo(144)
        }
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(title)
            $0.trailing.equalTo(imageView)
            $0.width.height.equalTo(24)
        }
    }
    

    public func update(model: ProductEntity, isBookMark: Bool = false, id: Int = 0) {

        self.imageView.kf.setImage(with: URL(string: model.mainImage), placeholder: DesignSystemAsset.PlaceHolder.largePH.image)
        self.title.text = model.name
        self.id = id // 북마크에서 사용될 값
        self.bookmarkButton.isHidden = !isBookMark
        
        self.imageHeight = model.width == 0 ? CGFloat(171) : CGFloat(171 * model.height / model.width)
        
        self.imageView.snp.updateConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalTo(171)
            $0.height.equalTo(self.imageHeight)
        }
        
        self.title.snp.updateConstraints {
            $0.top.equalTo(self.imageView.snp.bottom).offset(4)
            $0.leading.equalTo(self.imageView)
        }
        
        self.bookmarkButton.snp.updateConstraints {
            $0.top.equalTo(self.title)
            $0.trailing.equalTo(self.imageView)
        }
        
    }
}

// MARK: - objc 함수
extension PinterestCollectionViewCell {
    @objc
    private func touchUpBookmark() {
        delegate?.remove(id: id)
    }
    
}
