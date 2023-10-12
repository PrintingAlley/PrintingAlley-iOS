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
    }
    
    private let testLabel = UILabel().then {
        $0.textColor = UIColor.setColor(.mainBlue(.blue1000))
        $0.text = "test"
    }
    
    private let collectionView = UICollectionView(frame: <#T##CGRect#>, collectionViewLayout: <#T##UICollectionViewLayout#>)
    
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
    private func makeCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.delegate = self
            $0.dataSource = self
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        }
    }
}

extension HomeViewController {
    private func addSubViews() {
        view.addSubviews(contentView)
        contentView.addSubviews(scrollView)
        scrollView.addSubviews(testLabel)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(153)
            $0.leading.trailing.bottom.equalToSuperview()
            // bottom : superview - 탭바높이)
        }
        testLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalTo(contentView).inset(24)
            $0.bottom.equalToSuperview().inset(100)
        }
    }
}
