//
//  ContentsHeaderView.swift
//  MyPageFeature
//
//  Created by 박의서 on 2023/10/14.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import Then
import SnapKit
import DesignSystem

final class ContentsHeaderView: UICollectionReusableView {
    static let identifier = "ContentsHeaderView"
    
    private lazy var categoryCollectionView = makeCollectionView(scrollDirection: .vertical).then {
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private let contentsTitle = UILabel().then {
        $0.text = "인쇄 알아보기"
        $0.font = .setFont(.subtitle1)
    }
    
    private let showMoreView = UIView().then {
        $0.backgroundColor = .red
    }

    private let showMoreText = UILabel().then {
        $0.text = "더보기"
        $0.font = .setFont(.caption1)
    }
    
    private let showMoreIcon = UIImageView().then {
        $0.image = DesignSystemAsset.Icon.rightArrow.image
        $0.contentMode = .scaleAspectFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentsHeaderView {
    private func addSubviews() {
        showMoreView.addSubviews(showMoreText, showMoreIcon)
        addSubviews(categoryCollectionView, contentsTitle, showMoreView)
    }
    
    private func makeConstraints() {
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(172)
        }
        contentsTitle.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(42)
        }
        showMoreText.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        showMoreIcon.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(9)
            $0.leading.equalTo(showMoreText.snp.trailing).offset(3)
        }
        showMoreView.snp.makeConstraints {
            $0.centerY.equalTo(contentsTitle)
            $0.width.equalTo(44)
            $0.trailing.equalToSuperview()
        }
    }
}

extension ContentsHeaderView {
    private func makeCollectionView(scrollDirection: UICollectionView.ScrollDirection) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
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

extension ContentsHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        return CGSize(width: 60, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 줄 간격
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 옆 간격
        return 30
    }
}

extension ContentsHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 아이템 개수
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { // data bind
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath)
                as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
