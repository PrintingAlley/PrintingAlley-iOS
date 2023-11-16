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
import TagDomainInterface
import BaseDomainInterface


protocol ContentsHeaderViewDelegate: AnyObject {
    func categoryTap(id: Int,title: String)
}

final class ContentsHeaderView: UICollectionReusableView {
    static let identifier = "ContentsHeaderView"
    
    private var dataSource: [ChildrenTagEntity] = []
    
    private let cellSpacing: CGFloat = 34
    private let collectionViewInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
    private lazy var cellSize = CGSize(width: (APP_WIDTH() - 30 - 30 - cellSpacing * 3) / 4, height: 78)
    private let lineSpacing: CGFloat = 32
    
    public lazy var categoryCollectionView = makeCollectionView(scrollDirection: .vertical).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private let sectionLine = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey50))
    }
    
    private let contentsTitle = AlleyLabel("인쇄가 어려운 당신에게", textColor: .sub(.black),font: .subtitle1)
    
    private lazy var showMoreTouchButton = UIButton().then {
        $0.backgroundColor = .none
        $0.addTarget(self, action: #selector(navigateToAllContents), for: .touchDown)
    }
    
    private let showMoreContainer = UIView()

    private let showMoreText = AlleyLabel("더보기", font: .caption1)
    
    private let showMoreIcon = UIImageView().then {
        $0.image = DesignSystemAsset.Icon.rightArrow.image
        $0.contentMode = .scaleAspectFill
    }
    
    weak var delgate: ContentsHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .setColor(.sub(.white))
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContentsHeaderView {
    private func addSubviews() {
        addSubviews(categoryCollectionView, contentsTitle, sectionLine, showMoreContainer)
//        showMoreContainer.addSubviews(showMoreText, showMoreIcon)
//        showMoreContainer.addSubviews(showMoreTouchButton)
    }
    
    private func makeConstraints() {
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(188)
        }
        sectionLine.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        contentsTitle.snp.makeConstraints {
            $0.top.equalTo(sectionLine.snp.bottom).offset(HORIZON_MARGIN1())
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
        }
//        showMoreContainer.snp.makeConstraints {
//            $0.centerY.equalTo(contentsTitle)
//            $0.width.equalTo(44)
//            $0.trailing.equalToSuperview().inset(24)
//        }
//        showMoreText.snp.makeConstraints {
//            $0.leading.equalToSuperview()
//            $0.centerY.equalToSuperview()
//        }
//        showMoreIcon.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
//            $0.width.equalTo(9)
//            $0.leading.equalTo(showMoreText.snp.trailing).offset(3)
//        }
//        showMoreTouchButton.snp.makeConstraints {
//            $0.width.height.equalTo(40)
//            $0.edges.equalToSuperview()
//        }
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
    
    public func update(tagDataSource: [ChildrenTagEntity]) {
        self.dataSource = tagDataSource
        
        categoryCollectionView.reloadData()
    }
    
    @objc
    private func navigateToAllContents() {
        print("탭탭")
    }
}

extension ContentsHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 줄 간격
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 옆 간격
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionViewInsets
    }
}

extension ContentsHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 아이템 개수
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { // data bind
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath)
                as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        if !dataSource.isEmpty {
            cell.update(model: dataSource[indexPath.row])
        }
        
        
        return cell
    }
}


extension ContentsHeaderView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delgate?.categoryTap(id: dataSource[indexPath.row].id, title: dataSource[indexPath.row].name)
    }
}
