//
//  AfterSearchViewController.swift
//  SearchFeatueDemo
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem
import BaseFeature

final class AfterSearchViewController: UIViewController {
    var testRecommend: [RecommendModel] = [
        RecommendModel(title: "소량인쇄"),
        RecommendModel(title: "인쇄상담"),
        RecommendModel(title: "당일인쇄"),
        RecommendModel(title: "24시수령"),
        RecommendModel(title: "대형인쇄")
    ]
    
    private lazy var filterCollectionview = makeCollectionView(layout: LeftAlignedCollectionViewFlowLayout(), scrollDirection: .horizontal, delegate: self, dataSource: self).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
    }
    
    private lazy var printingTableView = UITableView().then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.separatorStyle = .none
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
    private func addSubview() {
        view.addSubviews(filterCollectionview, printingTableView)
    }
    
    private func makeConstraints() {
        filterCollectionview.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(32) // 컬렉션뷰 height, 위치 수정 필요
        }
        printingTableView.snp.makeConstraints {
            $0.top.equalTo(filterCollectionview.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension AfterSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        let tempLabel = AlleyLabel(testRecommend[indexPath.row].title, font: .body1).then {
            $0.sizeToFit()
        }
        return CGSize(width: tempLabel.frame.width + 20, height: tempLabel.frame.height + 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
}

extension AfterSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath)
                as? FilterButtonCollectionViewCell else { return UICollectionViewCell() }
        cell.dummyDataBind(model: testRecommend[indexPath.row], type: .basic, willChangeUI: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 아이템 개수
        return testRecommend.count
    }
}

extension AfterSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        106
    }
}

extension AfterSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PrintingTableViewCell.identifier, for: indexPath)
                as? PrintingTableViewCell else { return UITableViewCell() }
        return cell
    }

}
