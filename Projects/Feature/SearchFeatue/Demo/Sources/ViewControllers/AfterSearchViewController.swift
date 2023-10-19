//
//  AfterSearchViewController.swift
//  SearchFeatueDemo
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem

final class AfterSearchViewController: UIViewController {
    private lazy var filterCollectionview = makeCollectionView(layout: LeftAlignedCollectionViewFlowLayout(), scrollDirection: .horizontal).then {
        $0.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
    }
    
    private let printingTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .singleLine
        $0.separatorColor = .black.withAlphaComponent(0.1)
        $0.delegate = self
        $0.dataSource = self
        $0.register(PrintingTableViewCell.self, forCellReuseIdentifier: PrintingTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .setColor(.sub(.white))
        addSubview()
        makeConstraints()
    }
}

extension AfterSearchViewController {
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

extension AfterSearchViewController {
    private func addSubview() {
        view.addSubviews(filterCollectionview)
    }
    
    private func makeConstraints() {
        filterCollectionview.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50) // 컬렉션뷰 height, 위치 수정 필요
        }
    }
}

extension AfterSearchViewController: UICollectionViewDelegateFlowLayout {
    
}

extension AfterSearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath)
                as? FilterButtonCollectionViewCell else { return UICollectionViewCell() }
//        cell.dummyDataBind(model: testRecommend[indexPath.row], type: .basic)
        return cell
    }
}

extension AfterSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension AfterSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PrintingTableViewCell.identifier, for: indexPath)
                as? PrintingTableViewCell else { return UITableViewCell() }
        
//        cell.dataBind(model: musicList[indexPath.row])
        return cell
    }

}
