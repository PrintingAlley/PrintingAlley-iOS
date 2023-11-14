//
//  PrintShopProudctsViewController.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/14.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import UtilityModule
import SnapKit
import Then

public class PrintShopProudctsViewController: UIViewController {

    let viewModel: PrintShopProudctsViewModel!
    
    private lazy var gridLayout = AutoHeightCollectionViewLayout().then {
        $0.delegate = self
    }
    
    private lazy var productsGridView = UICollectionView(frame: .zero, collectionViewLayout: gridLayout).then {
        $0.dataSource = self
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
        $0.register(PinterestCollectionViewCell.self, forCellWithReuseIdentifier: PinterestCollectionViewCell.identifer)
    }
    
    init(viewModel: PrintShopProudctsViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addSubViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PrintShopProudctsViewController {
    private func addSubViews() {
        view.addSubviews(productsGridView)
    }
    
    private func makeConstraints() {
        productsGridView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension PrintShopProudctsViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PinterestCollectionViewCell.identifer, for: indexPath) as? PinterestCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.update(model: viewModel.products[indexPath.row])
        return cell
    }
}

extension PrintShopProudctsViewController: AutoHeightLayoutDelegate {
    public func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let product = viewModel.products[indexPath.row]
        
        return CGFloat(product.height * 171 / product.width)
    }
}
