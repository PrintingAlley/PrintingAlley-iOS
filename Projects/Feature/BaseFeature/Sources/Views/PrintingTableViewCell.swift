//
//  PrintingTableViewCell.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import BaseDomainInterface

public final class PrintingTableViewCell: UITableViewCell {
    public static let identifier = "PrintingTableViewCell"
    
    private let image = UIImageView().then {
        $0.image = DesignSystemAsset.Icon.bookMark.image
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .lightGray
        $0.setRound([.allCorners], radius: 9)
    }
    
    private let name = AlleyLabel("정다운 인쇄소", textColor: .sub(.black), font: .subtitle1)
    
    private let printingTag = AlleyLabel("인쇄 / 후가공", textColor: .mainBlue(.blue500), font: .subtitle3)
    
    private let descriptioin = AlleyLabel("엽서, 카드 #상담가능", textColor: .sub(.black), font: .body2)
    
    private let address = AlleyLabel("서울 중구 퇴계로39길 11", textColor: .grey(.grey300), font: .body2)
    
    private let separator = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey100))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI 관련 함수
extension PrintingTableViewCell {
    private func addSubview() {
        contentView.addSubviews(separator, image, name, printingTag, descriptioin, address)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        separator.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        image.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(74)
        }

        name.snp.makeConstraints {
            $0.top.equalTo(image)
            $0.leading.equalTo(image.snp.trailing).offset(16)
        }
        
        printingTag.snp.makeConstraints {
            $0.leading.equalTo(name.snp.trailing).offset(6)
            $0.centerY.equalTo(name)
        }
        
        descriptioin.snp.makeConstraints {
            $0.leading.equalTo(name)
            $0.top.equalTo(name.snp.bottom).offset(2)
        }
        
        address.snp.makeConstraints {
            $0.leading.equalTo(name)
            $0.top.equalTo(descriptioin.snp.bottom).offset(2)
        }
    }
}

// MARK: - 데이터 바인딩 함수
public extension PrintingTableViewCell {
     func bindData(model: PrintShopEntity) {
        // TODO: 이미지 바인딩
        self.name.text = model.name
        self.printingTag.text = model.tags.joined(separator: " ")
        self.descriptioin.text = model.introduction
        self.address.text = model.address
    }
}
