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
    
    private let categoryTitle = AlleyLabel("어떤 작품을 찾으시나요?", textColor: .sub(.black), font: .subtitle1)
    
    private let categorySubTitle = AlleyLabel("다양한 인쇄 장인들의 작품을 만나보세요", textColor: .grey(.grey400), font: .body2)
    
    public lazy var categoryCollectionView = makeCollectionView(scrollDirection: .vertical).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.contentInset = UIEdgeInsets(top: 20, left: 24, bottom: 32, right: 24)
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private let sectionLine = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey50))
    }
    
    private let contentsTitle = AlleyLabel("인쇄 콘텐츠 둘러보기", textColor: .sub(.black),font: .subtitle1)
    
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
        addSubviews(categoryTitle, categorySubTitle, categoryCollectionView, contentsTitle, sectionLine, showMoreContainer)
//        showMoreContainer.addSubviews(showMoreText, showMoreIcon)
//        showMoreContainer.addSubviews(showMoreTouchButton)
    }
    
    private func makeConstraints() { // 수퍼뷰: view.safeArea
        categoryTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(48)
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        categorySubTitle.snp.makeConstraints {
            $0.top.equalTo(categoryTitle.snp.bottom).offset(3)
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
        }
        
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalTo(categorySubTitle.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(188 + categoryCollectionView.contentInset.top + categoryCollectionView.contentInset.bottom)
        }
        sectionLine.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(10)
        }
        contentsTitle.snp.makeConstraints {
            $0.top.equalTo(sectionLine.snp.bottom).offset(32)
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
