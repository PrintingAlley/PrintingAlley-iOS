//
//  CopyButton.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/11/14.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit

public final class CopyButton: UIButton {
    public init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CopyButton {
    private func configureUI() {
        self.setTitle("복사", for: .normal)
        self.setTitleColor(DesignSystemAsset.MainBlue.blue500.color, for: .normal)
        self.titleLabel?.font = .setFont(.body2)
        self.setImage(DesignSystemAsset.Icon.copy.image, for: .normal)
        self.contentHorizontalAlignment = .center // // how to position content horizontally inside control. default is center
        self.semanticContentAttribute = .forceLeftToRight // 이미지 왼쪽에 배치
        self.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 4) //<- 중요
    }
}
