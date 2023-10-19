//
//  PrintingTableViewCell.swift
//  SearchFeatueDemo
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem

final class PrintingTableViewCell: UITableViewCell {
    private let image = UIImageView().then {
        $0.setRound([.allCorners], radius: 9)
    }
    
    private let name = UILabel().then {
        $0.text = "정다운인쇄소"
        $0.font = UIFont.setFont(.subtitle1)
    }
    
    static let identifier = "PrintingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrintingTableViewCell {
    private func addSubview() {
        contentView.addSubviews(image)
    }
    
    private func makeConstraints() {
//        image.snp.makeConstraints {
//
//        }
    }
}
