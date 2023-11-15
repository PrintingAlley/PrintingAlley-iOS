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

public class PrintShopProductsViewController: UIViewController {

    let viewModel: PrintShopProductsViewModel!
    
    private lazy var gridLayout = AutoHeightCollectionViewLayout().then {
        $0.delegate = self
    }
    
    private lazy var productsGridView = UICollectionView(frame: .zero, collectionViewLayout: gridLayout).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        $0.dataSource = self
        $0.showsHorizontalScrollIndicator = false
        $0.register(PinterestCollectionViewCell.self, forCellWithReuseIdentifier: PinterestCollectionViewCell.identifer)
    }
    
    init(viewModel: PrintShopProductsViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        addSubViews()
        makeConstraints()
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PrintShopProductsViewController {
    private func addSubViews() {
        view.addSubviews(productsGridView)
    }
    
    private func makeConstraints() {
        productsGridView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PrintShopProductsViewController {
    func bindViewModel() {
        if viewModel.products.isEmpty {
            self.productsGridView.setEmptyMessage("작품이 없습니다.")
        }
    }
}

extension PrintShopProductsViewController: UICollectionViewDataSource {
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

extension PrintShopProductsViewController: AutoHeightLayoutDelegate {
    public func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let product = viewModel.products[indexPath.row]
        
        return CGFloat(product.height * 171 / product.width)
    }
}
