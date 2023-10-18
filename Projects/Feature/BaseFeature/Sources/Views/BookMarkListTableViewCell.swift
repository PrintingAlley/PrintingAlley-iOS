//
//  BookMarkTableViewCell.swift
//  BookMarkModuleDemo
//
//  Created by yongbeomkwak on 10/14/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem



class BookMarkListTableViewCell: UITableViewCell {

    static let identifier: String = "BookMarkListTableViewCell"
    
    lazy var frontImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = DesignSystemAsset.Icon.add.image
    }
    
    lazy var titleLabel: AlleyLabel = AlleyLabel()
    lazy var subtitleLabel: AlleyLabel = AlleyLabel()
    
    lazy var rightArrowImageView: UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.image = DesignSystemAsset.Icon.rightArrow.image
    }
    
    lazy var baseLine: UIView = UIView().then{
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            addSubviews()
            makeConstraints()
        
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension BookMarkListTableViewCell {
    func addSubviews() {
        self.addSubviews(titleLabel,subtitleLabel,rightArrowImageView,frontImageView,baseLine)
    }
    
    func makeConstraints() {
        
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview().inset(24)
            $0.top.equalToSuperview()
        }
        
        frontImageView.snp.makeConstraints {
            $0.width.height.equalTo(32)
            $0.top.bottom.equalToSuperview().inset(22)
            $0.left.equalToSuperview().inset(24)
        }
        
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.left.equalTo(frontImageView.snp.right).offset(16)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.equalTo(titleLabel.snp.left)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        rightArrowImageView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalTo(frontImageView.snp.centerY)
            $0.right.equalToSuperview().inset(24)

        }
        

        
        
    }
    
    public func update(model: TmpModel) {
        
        titleLabel.setTitle(title: model.name, textColor: .grey(.grey1000), font: .body1)
        subtitleLabel.setTitle(title: "장소 \(model.contents.count)개", textColor: .grey(.grey500), font: .caption1)
        
    }
    

}

public struct TmpModel {
    let name: String
    let contents: [TmpContentModel]
    var isSelected: Bool = false
    
    static func makeDummy() -> [Self] {
        [TmpModel(name: "즐겨찾기 1", contents: [TmpContentModel(name: "정다운 인쇄소 1", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80"), TmpContentModel(name: "정다운 인쇄소 2", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80")]),
          TmpModel(name: "즐겨찾기 1", contents: [TmpContentModel(name: "정다운 인쇄소 1", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80"), TmpContentModel(name: "정다운 인쇄소 2", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80"), TmpContentModel(name: "정다운 인쇄소 2", options: ["인쇄","후가공"], adress: "경북 포항시 남구 지곡로 80")])]
    }
}

struct TmpContentModel {
    let name: String
    let options: [String]
    let adress: String
}
