//
//  SearchBar.swift
//  DesignSystem
//
//  Created by 박의서 on 2023/10/15.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit

public final class SearchBar: UIView {
    private let searchTextField = UITextField().then {
        let attributedPlaceholder = NSAttributedString(string: "플레이스 홀더 색상 바꾸기!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.setColor(.grey(.grey400)), NSAttributedString.Key.font: UIFont.setFont(.body1)])
        $0.attributedPlaceholder = attributedPlaceholder
        $0.placeholder = "인쇄소, 후가공, 인쇄방식 검색"
    }
    
    private lazy var searchButton = UIButton().then {
        $0.addTarget(self, action: #selector(touchSearchIcon), for: .touchUpInside)
        $0.setImage(DesignSystemAsset.Icon.search.image, for: .normal)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI 관련 함수
extension SearchBar {
    private func configureUI() {
        DispatchQueue.main.async {
            self.setRound([.allCorners], radius: self.frame.height / 2)
        }
        self.backgroundColor = .setColor(.sub(.white))
        self.layer.borderColor = UIColor.setColor(.grey(.grey100)).cgColor
        self.layer.borderWidth = 1.0
    }
    
    private func addSubviews() {
        self.addSubviews(searchTextField, searchButton)
    }
    
    private func makeConstraints() {
        searchTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(23)
        }
    }
}

// MARK: - Objc 함수
extension SearchBar {
    @objc
    private func touchSearchIcon() {
        print("검색")
    }
}
