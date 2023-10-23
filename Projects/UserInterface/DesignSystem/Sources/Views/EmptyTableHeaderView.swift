//
//  EmptyTableHeaderView.swift
//  DesignSystem
//
//  Created by yongbeomkwak on 10/20/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit


public class EmptyTableHeaderView: UIView {

    lazy var label:AlleyLabel = AlleyLabel().then{
        $0.numberOfLines = 0
    }
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(frame: CGRect,text: String) {
        self.init(frame: frame)
        self.addSubviews(label)
        
        label.setTitle(title: text, textColor: .grey(.grey500), font: .body1,alignment: .center)
        
        label.snp.makeConstraints{
            $0.bottom.left.right.equalToSuperview()
        }
    }


    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }

}
