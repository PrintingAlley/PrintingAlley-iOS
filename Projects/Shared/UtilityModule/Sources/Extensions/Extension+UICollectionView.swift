//
//  Extension+UICollectionView.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 11/3/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import DesignSystem
import UIKit
import SnapKit

public extension UICollectionView {
    
    /// 컬렉션 뷰의 간단한 emptyView
    /// - Parameter text: 띄우줄 텍스트 
    public func setEmptyMessage(_ text: String) {
        
        let label: AlleyLabel = AlleyLabel(text, textColor: .grey(.grey500), font: .body1,alignment: .center)
    
        let view = UIView(frame: CGRect(x: .zero, y: .zero, width: APP_WIDTH(), height: APP_HEIGHT()))
        
        view.addSubview(label)
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(60)
            $0.left.right.equalToSuperview()
        }
        
        
        self.backgroundView = view
    }
    
    public func restore() {
        self.backgroundView = nil 
    }
    
}
