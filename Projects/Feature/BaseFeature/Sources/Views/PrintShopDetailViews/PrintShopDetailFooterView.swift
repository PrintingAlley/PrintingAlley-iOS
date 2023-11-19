//
//  PrintShopDetailFooterView.swift
//  BaseFeature
//
//  Created by 박의서 on 11/19/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem
import UtilityModule

final class PrintShopDetailFooterView: UIView {
    
    static let identifier = "PrintShopDetailFooterView"
    
    private let introductionIcon = UIImageView().then {
        $0.image = DesignSystemAsset.Icon.dotTextBubble.image
        $0.contentMode = .scaleToFill
    }
    
    private let introductionLabel = AlleyLabel("인트로덕션", textColor: .sub(.black), font: .body2)
    
    private let separateLine = UIView().then {
        $0.backgroundColor = .setColor(.grey(.grey100))
    }
    
    private lazy var printTypeInfoTableView = UITableView().then { // grey 배경 포함
        $0.delegate = self
        $0.dataSource = self
        $0.register(PrintTypeInfoTableViewCell.self, forCellReuseIdentifier: PrintTypeInfoTableViewCell.identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrintShopDetailFooterView {
    private func addSubviews() {
        self.addSubviews(introductionIcon, introductionLabel, separateLine, printTypeInfoTableView)
    }
    
    private func makeConstraints() {
        introductionIcon.snp.makeConstraints {            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.width.height.equalTo(24)
        }
        
        introductionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.leading.equalTo(introductionIcon.snp.trailing).offset(10)
        }
        
        separateLine.snp.makeConstraints {
            $0.bottom.equalTo(introductionIcon.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.height.equalTo(0.8)
        }
        
        printTypeInfoTableView.snp.makeConstraints {
            $0.top.equalTo(separateLine.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(HORIZON_MARGIN1())
            $0.height.equalTo(200) // 높이 다시 잡기
        }
    }
}

extension PrintShopDetailFooterView: UITableViewDelegate {
    
}

extension PrintShopDetailFooterView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrintTypeInfoTableViewCell.identifier, for: indexPath) as? PrintTypeInfoTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }

}
