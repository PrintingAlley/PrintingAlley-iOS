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
    
    private let backButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
    }
    
    private let searchBar = SearchBar()
    
    private let recommendView = UIView()
    
    private let recommendTitle = AlleyLabel("추천 검색어", textColor: .sub(.black), font: .subtitle1)
    
    private let test = FilterButton(title: "스프링노트", type: .selectedWithX)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .setColor(.sub(.white))
        addSubviews()
        makeConstraints()
    }
}

extension SearchViewController {
    private func addSubviews() {
        view.addSubviews(navigationView, recommendView)
        navigationView.addSubviews(backButton, searchBar)
        recommendView.addSubviews(recommendTitle, test)
    }
    
    private func makeConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(17)
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
        
        recommendTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalToSuperview().inset(24)
        }
        
        test.snp.makeConstraints {
            $0.top.equalTo(recommendTitle.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(24)
        }
    }
}
