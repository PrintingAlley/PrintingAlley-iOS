//
//  SearchViewController.swift
//  SearchFeatueDemo
//
//  Created by 박의서 on 2023/10/16.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import DesignSystem

final class SearchViewController: UIViewController {
    
    private let navigationView = UIView()
    
    private lazy var backButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
        $0.addTarget(self, action: #selector(touchBackbtn), for: .touchUpInside)
    }
    
    private let searchBar = SearchBar()
    
    private let recommendView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .setColor(.sub(.white))
        addSubviews()
        makeConstraints()
        setKeyboardDown()
    }
}

extension SearchViewController {
    private func setKeyboardDown() {
        let keyboardDownGesture = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        self.view.addGestureRecognizer(keyboardDownGesture)
    }
    
    private func addSubviews() {
        view.addSubviews(navigationView, recommendView)
        navigationView.addSubviews(backButton, searchBar)
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(32)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(8)
            $0.width.equalTo(317)
            $0.height.equalTo(52)
            $0.centerY.equalToSuperview()
        }
        
        recommendView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(125)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - TextField Delegate
extension SearchViewController: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

// MARK: - Objc 함수
extension SearchViewController {
    @objc
    private func touchBackbtn() {
        print("back button")
    }
}
