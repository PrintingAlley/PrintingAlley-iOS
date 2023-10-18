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
    var testRecommend: [RecommendModel] = [
        RecommendModel(title: "스프링노트"),
        RecommendModel(title: "리소인쇄"),
        RecommendModel(title: "레터프레스"),
        RecommendModel(title: "하이"),
        RecommendModel(title: "아아아아아아아아아"),
        RecommendModel(title: "리소인쇄"),
        RecommendModel(title: "카테고리"),
        RecommendModel(title: "카테고리")
    ]
    
    private let navigationView = UIView()
    
    private let backButton = UIButton().then {
        $0.setImage(DesignSystemAsset.Icon.back.image, for: .normal)
    }
    
    private let searchBar = SearchBar()
    
    private let recommendView = UIView()
    
    private let recommendTitle = AlleyLabel("추천 검색어", textColor: .sub(.black), font: .subtitle1)
    
    private lazy var recommendCollectionView = makeCollectionView(scrollDirection: .vertical).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
    }
    
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
        recommendView.addSubviews(recommendTitle, recommendCollectionView)
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
        
        recommendCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendTitle.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(400)
        }
    }
}

extension SearchViewController {
    private func makeCollectionView(scrollDirection: UICollectionView.ScrollDirection) -> UICollectionView {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = scrollDirection
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 6
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.delegate = self
            $0.dataSource = self
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        return collectionView
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        let tempLabel = AlleyLabel(testRecommend[indexPath.row].title, font: .body1).then {
            $0.sizeToFit()
        }
        
        return CGSize(width: tempLabel.frame.width + 20, height: tempLabel.frame.height + 8)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath)
                as? RecommendCollectionViewCell else { return UICollectionViewCell() }
        cell.dummyDataBind(model: testRecommend[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 아이템 개수
        return testRecommend.count
    }

}
