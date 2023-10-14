//
//  BookMarkTableViewCell.swift
//  BookMarkModuleDemo
//
//  Created by yongbeomkwak on 10/14/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import DesignSystem

public protocol BookMarkTableViewCellDelegate: AnyObject {
    func tapMore()
}

class BookMarkTableViewCell: UITableViewCell {

    static let identifier: String = "BookMarkTableViewCell"
    
    lazy var containerView: UIView = UIView()
    lazy var titleLabel: AlleyLabel = AlleyLabel()
    lazy var subtitleLabel: AlleyLabel = AlleyLabel()
    lazy var button: UIButton = UIButton().then{
        $0.setImage(DesignSystemAsset.Icon.more.image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFill
    }
    
    lazy var baseLine:UIView = UIView().then{
        $0.backgroundColor = .black.withAlphaComponent(0.1)
    }
    
    public weak var deleagte: BookMarkTableViewCellDelegate?
    var model:TmpModel!
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubviews()
            makeConstraints()
            button.addTarget(self, action: #selector(tapMore), for: .touchUpInside)
        
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension BookMarkTableViewCell {
    func addSubviews(){
        self.contentView.addSubviews(containerView,baseLine)
        self.containerView.addSubviews(titleLabel,subtitleLabel,button)
    }
    
    func makeConstraints() {
        
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(26)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.left.equalTo(titleLabel.snp.left)
            $0.bottom.equalToSuperview()
        }
        
        button.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.centerY.right.equalToSuperview()
        }
        
        baseLine.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.right.equalTo(containerView)
            $0.top.equalTo(containerView.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
        
        
    }
    
    public func update(model: TmpModel) {
        self.model = model
        
        titleLabel.setTitle(title: model.name, textColor: .grey(.grey1000), font: .body1)
        subtitleLabel.setTitle(title: "장소 \(model.contents.count)개", textColor: .grey(.grey500), font: .caption1)
        
        
    }
    
    @objc func tapMore() {
        deleagte?.tapMore()
    }
}
