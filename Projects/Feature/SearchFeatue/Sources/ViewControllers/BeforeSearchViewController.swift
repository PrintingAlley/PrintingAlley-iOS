//
//  BeforeSearchViewController.swift
//  SearchFeatueInterface
//
//  Created by 박의서 on 2023/10/18.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import Then
import SnapKit
import DesignSystem
import BaseFeature
import UtilityModule
import RxSwift

final class BeforeSearchViewController: UIViewController {
    private var viewModel: BeforeSearchViewModel!
    
    private let disposeBag = DisposeBag()
    private var output: BeforeSearchViewModel.Output!

    private let recommendTitle = AlleyLabel("추천 검색어", textColor: .sub(.black), font: .subtitle1)
    
    private lazy var recommendCollectionView = makeCollectionView(layout: LeftAlignedCollectionViewFlowLayout(), scrollDirection: .vertical, delegate: self, dataSource: self).then {
        $0.backgroundColor = .setColor(.sub(.white))
        $0.register(FilterButtonCollectionViewCell.self, forCellWithReuseIdentifier: FilterButtonCollectionViewCell.identifier)
    }
    
    init(viewModel: BeforeSearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCommonUI()
        addSubview()
        makeConstraints()
        bindViewModel()
    }
}

// MARK: - 데이터 바인딩 함수들
extension BeforeSearchViewController {
    private func bindViewModel() {
        let input = BeforeSearchViewModel.Input()
        
        output = viewModel.transform(input: input)
        
        bindViewDidLoad(input: input)
        bindRecommendDatasource(output: output)
    }
    
    private func bindViewDidLoad(input: BeforeSearchViewModel.Input) {
        input.viewDidLoad.onNext(())
    }
    
    private func bindRecommendDatasource(output: BeforeSearchViewModel.Output) {
        output.dataSource
            .withUnretained(self)
            .subscribe(onNext: { (owner, dataSource) in
                DEBUG_LOG(dataSource)
                owner.recommendCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UI 관련 함수들
extension BeforeSearchViewController {
    private func addSubview() {
        view.addSubviews(recommendTitle, recommendCollectionView)
    }
    
    private func makeConstraints() {
        recommendTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(17)
            $0.leading.equalToSuperview().inset(24)
        }
        
        recommendCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendTitle.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(400)
        }
    }
}

// MARK: - Collectionview 관련 함수들
extension BeforeSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 셀 크기
        let tempLabel = AlleyLabel(RecommendModel.makeDummy()[indexPath.row].title, font: .body1).then {
            $0.sizeToFit()
        }
        return CGSize(width: tempLabel.frame.width + 20, height: tempLabel.frame.height + 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
}

extension BeforeSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterButtonCollectionViewCell.identifier, for: indexPath)
                as? FilterButtonCollectionViewCell else { return UICollectionViewCell() }
//        cell.update(model: RecommendModel.makeDummy()[indexPath], type: .basic, willChangeUI: false)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 아이템 개수
        return RecommendModel.makeDummy().count
    }

}
