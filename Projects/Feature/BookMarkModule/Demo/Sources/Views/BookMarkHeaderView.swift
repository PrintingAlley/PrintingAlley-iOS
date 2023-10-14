//
//  BookMarkHeaderView.swift
//  BookMarkModuleDemo
//
//  Created by yongbeomkwak on 10/14/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import DesignSystem


protocol BookMarkHeaderViewDelegate: AnyObject {
    func action()-> Void
}

class BookMarkHeaderView: UIView {

    lazy var button:UIButton = UIButton().then {
        $0.layer.cornerRadius = 20
        $0.layer.borderColor = DesignSystemAsset.Grey.grey100.color.cgColor
        $0.layer.borderWidth = 1
        
        $0.setTitle("새 목록", for: .normal)
        $0.setImage(DesignSystemAsset.Icon.add.image, for: .normal)
        $0.setTitleColor(DesignSystemAsset.MainBlue.blue500.color, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.titleLabel?.font = .setFont(.subtitle2)
        $0.contentHorizontalAlignment = .center // // how to position content horizontally inside control. default is center
        $0.semanticContentAttribute = .forceLeftToRight //<- 중요
        $0.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 10) //<- 중요
        
    }
    
    weak var delegate:BookMarkHeaderViewDelegate?
    
//    init(){
//        super.init(frame: .zero)
//        
//        addSubviews()
//        makeConstraints()
//        preProcessing()
//        
//        
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
        preProcessing()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

}

extension BookMarkHeaderView {
    
    func preProcessing() {
        button.addTarget(self, action: #selector(add), for: .touchUpInside)
    }
    
    func addSubviews() {
        self.addSubview(button)
    }
    
    func makeConstraints() {
        button.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
    
    @objc func add() {
        delegate?.action()
    }
}
