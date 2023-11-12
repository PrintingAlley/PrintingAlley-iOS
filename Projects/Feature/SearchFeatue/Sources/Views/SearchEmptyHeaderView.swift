//
//  SearchEmptyHeaderView.swift
//  SearchFeatue
//
//  Created by 박의서 on 2023/11/12.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import SnapKit
import Then

class SearchEmptyHeaderView: UIView {
    
    public let identifier = "SearchEmptyHeaderView"

    public lazy var titleLabel: AlleyLabel = AlleyLabel("검색 결과가 없어요.", textColor: .sub(.black), font: .subtitle2, alignment: .center)
    
    public lazy var subtitleLabel: AlleyLabel = AlleyLabel("검색어를 바르게 입력했는지 확인하고,\n더 간단한 단어로 검색해 보세요.\n(예: 중철제본 책→ 중철제본)", textColor: .grey(.grey300), font: .subtitle3, alignment: .center)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews(titleLabel, subtitleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview().inset(222)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
}
