//
//  CustomFloatingPanelLayout.swift
//  UtilityModule
//
//  Created by yongbeomkwak on 10/26/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import FloatingPanel

public class CustomFloatingPanelLayout: FloatingPanelLayout {
    public var position: FloatingPanelPosition = .bottom
    public var initialState: FloatingPanelState = .tip
    
    public init() {
        
    }
    
    public var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .full: FloatingPanelLayoutAnchor(fractionalInset: 1.0, edge: .bottom, referenceGuide: .superview),
            .half: FloatingPanelLayoutAnchor(fractionalInset: 0.8, edge: .bottom, referenceGuide: .superview),
            .tip: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .superview)
        ]
    }
    
    public func backdropAlpha(for state: FloatingPanelState) -> CGFloat { // 뒷 배경
        0.3
    }
}
