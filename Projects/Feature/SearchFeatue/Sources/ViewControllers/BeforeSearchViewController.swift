//
//  BeforeSearchViewController.swift
//  SearchFeatueInterface
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import DesignSystem
import BaseFeature

final class BeforeSearchViewController: UIViewController {
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

    private let recommendTitle = AlleyLabel("추천 검색어", textColor: .sub(.black), font: .subtitle1)
    
    private lazy var recommendCollectionView = makeCollectionView(layout: LeftAlignedCollectionViewFlowLayout(), scrollDirection: .vertical).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .setColor(.sub(.white))
        addSubview()
        makeConstraints()
    }
}

extension BeforeSearchViewController {
    private func addSubview() {
        view.addSubviews(recommendTitle, recommendCollectionView)
    }
    
    private func makeConstraints() {
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

extension BeforeSearchViewController {
    private func makeCollectionView(layout: UICollectionViewFlowLayout, scrollDirection: UICollectionView.ScrollDirection) -> UICollectionView {
        layout.scrollDirection = scrollDirection
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.delegate = self
            $0.dataSource = self
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
        }
        return collectionView
    }
}

extension BeforeSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        let tempLabel = AlleyLabel(testRecommend[indexPath.row].title, font: .body1).then {
            $0.sizeToFit()
        }
        return CGSize(width: tempLabel.frame.width + 20, height: tempLabel.frame.height + 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
}

extension BeforeSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath)
                as? FilterButtonCollectionViewCell else { return UICollectionViewCell() }
        cell.dummyDataBind(model: testRecommend[indexPath.row], type: .basic, willChangeUI: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 아이템 개수
        return testRecommend.count
    }

}
