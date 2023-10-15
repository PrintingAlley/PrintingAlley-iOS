//
//  HomeViewController.swift
//  HomeFeatureInterface
//
//  Created by 박의서 on 2023/10/11.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import UtilityModule
import Then
import SnapKit

final class HomeViewController: UIViewController {
    private let contentView = UIView().then {
        $0.backgroundColor = .setColor(.mainBlue(.blue500))
    }
    
    private let scrollView = UIScrollView().then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.layer.cornerRadius = 12 // top left, right만 적용되도록
    }
    
    private lazy var contentsCollectionView = makeCollectionView(scrollDirection: .vertical).then {
        $0.tag = 1
        $0.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: ContentsCollectionViewCell.identifier)
        $0.register(ContentsHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ContentsHeaderView.identifier)
    }
    
    private let contentsInsets = UIEdgeInsets(top: 16, left: 0, bottom: 20, right: 0)
    
    var viewModel: HomeViewModel!
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        makeConstraints()
    }
}

extension HomeViewController {
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
    
    private func calculateHeight(count: Int, dividingBy: CGFloat, cellHeight: CGFloat, lineSpacing: CGFloat, insets: UIEdgeInsets) -> CGFloat { // count: List.cound
        let count = CGFloat(count)
        let heightCount = count / dividingBy + count.truncatingRemainder(dividingBy: dividingBy)
        return heightCount * cellHeight + (heightCount - 1) * lineSpacing + insets.top + insets.bottom
    }
}

extension HomeViewController {
    private func addSubViews() {
        view.addSubviews(contentView)
        contentView.addSubviews(scrollView)
        scrollView.addSubviews(contentsCollectionView)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(153)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentsCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(calculateHeight(count: 10, dividingBy: 2, cellHeight: 201, lineSpacing: 24, insets: contentsInsets)) // 유동적으로
            $0.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        return CGSize(width: 163, height: 201)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 줄 간격
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 옆 간격
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ContentsHeaderView.identifier, for: indexPath) as! ContentsHeaderView
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        // 헤더 뷰의 크기 반환
        return CGSize(width: APP_WIDTH(), height: 280)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        contentsInsets
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 아이템 개수
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { // data bind
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.identifier, for: indexPath)
                as? ContentsCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
