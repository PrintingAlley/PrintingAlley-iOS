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

public protocol SearchBarDelegate: AnyObject {
    func press()
    func resetPage()
}

public final class SearchBar: UIView {

    public weak var delegate: SearchBarDelegate?
    
    public lazy var searchTextField = UITextField().then {
        let attributedPlaceholder = NSAttributedString(string: "플레이스 홀더 색상 바꾸기!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.setColor(.grey(.grey400)), NSAttributedString.Key.font: UIFont.setFont(.body1)])
        $0.attributedPlaceholder = attributedPlaceholder
        $0.placeholder = "인쇄 방식, 후가공, 인쇄사 이름 검색"
        $0.textColor = .setColor(.sub(.black))
        $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        $0.returnKeyType = .search
    }
    
    private lazy var searchButton = UIButton().then {
        $0.addTarget(self, action: #selector(touchSearchIcon), for: .touchUpInside)
        $0.setImage(DesignSystemAsset.Icon.search.image, for: .normal)
    }
    
    private lazy var touchField = UIView().then {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchSearchBar))
        $0.addGestureRecognizer(tapGesture)
    }
    
    override public func layoutSubviews() {
        self.setRound([.allCorners], radius: self.frame.height / 2)
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
        self.backgroundColor = .setColor(.sub(.white))
        self.layer.borderColor = UIColor.setColor(.grey(.grey100)).cgColor
        self.layer.borderWidth = 1.0
    }
    
    private func addSubviews() {
        self.addSubviews(searchTextField, searchButton, touchField)
    }
    
    private func makeConstraints() {
        searchTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(23)
        }
        
        touchField.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.trailing.equalTo(searchButton.snp.leading)
        }
    }
}

// MARK: - Objc 함수
extension SearchBar {
    @objc
    public func touchSearchIcon() {
            searchTextField.text?.removeAll()
            searchButton.setImage(DesignSystemAsset.Icon.search.image, for: .normal)
            delegate?.press()
    }
    
    @objc
    private func textFieldDidChange() {
        if searchTextField.hasText {
            searchButton.setImage(DesignSystemAsset.Icon.mediumClose.image, for: .normal)
            
            delegate?.resetPage()
        }
    }
    
    @objc
    private func touchSearchBar() {
        searchTextField.becomeFirstResponder()
    }
}

extension SearchBar: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
