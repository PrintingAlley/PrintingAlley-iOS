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
    
    private lazy var categoryCollectionView = makeCollectionView(scrollDirection: .horizontal).then {
        $0.tag = 0
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private lazy var contentsCollectionView = makeCollectionView(scrollDirection: .vertical).then {
        $0.tag = 1
        $0.register(ContentsCollectionViewCell.self, forCellWithReuseIdentifier: ContentsCollectionViewCell.identifier)
    }
    
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
}

extension HomeViewController {
    private func addSubViews() {
        view.addSubviews(contentView)
        contentView.addSubviews(scrollView)
        scrollView.addSubviews(categoryCollectionView, contentsCollectionView)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(153)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            // bottom : superview - 탭바높이)
        }
        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(174)
        }
        contentsCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(800) // 수정
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        switch collectionView.tag {
        case 0:
            return CGSize(width: 80, height: 40)

        case 1:
            return CGSize(width: 163, height: 201)

        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 옆 간격
        switch collectionView.tag {
        case 0:
            return 20

        case 1:
            return 16

        default:
            return 0
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 아이템 개수
        switch collectionView.tag {
        case 0:
            return 8

        case 1:
            return 8

        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { // data bind
        switch collectionView.tag {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath)
                          as? CategoryCollectionViewCell else { return UICollectionViewCell() }
            return cell

        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentsCollectionViewCell.identifier, for: indexPath)
                          as? ContentsCollectionViewCell else { return UICollectionViewCell() }
            return cell

        default:
            return UICollectionViewCell()
        }
    }
}
