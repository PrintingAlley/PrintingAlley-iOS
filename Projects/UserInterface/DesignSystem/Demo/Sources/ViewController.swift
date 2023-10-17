//
//  ViewController.swift
//  DesignSystemDemo
//
//  Created by yongbeomkwak on 10/15/23.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import SnapKit
import Then
import FloatingPanel

class ViewController: UIViewController {

    var fpc: FloatingPanelController!
    
    var button: UIButton = UIButton().then {
        $0.setTitle("Press", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(button)
        self.view.backgroundColor = .white
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
    }
    
    @objc func action() {
        let vc = BookMarkBottomSheetViewController(viewModel: BookMarkBottomSheetViewModel())
        fpc = FloatingPanelController()
        
        // Create a new appearance.
        let appearance = SurfaceAppearance()

        // Define shadows
//        let shadow = SurfaceAppearance.Shadow()
//        shadow.color = UIColor.black
//        shadow.offset = CGSize(width: 0, height: 16)
//        shadow.radius = 16
//        shadow.spread = 8
//        appearance.shadows = [shadow]

        // Define corner radius and background color
        appearance.cornerRadius = 8.0
        appearance.backgroundColor = .clear

        // Set the new appearance
        fpc.surfaceView.appearance = appearance
        
        fpc.set(contentViewController: vc)
        fpc.isRemovalInteractionEnabled = true // 끌어 내려 닫기
        
        // Hidden grabber
        fpc.surfaceView.grabberHandle.isHidden = true
        
        fpc.addPanel(toParent: self)
        
        fpc.layout = CustomFloatingPanelLayout()
        fpc.show()
      
    }


}

class CustomFloatingPanelLayout: FloatingPanelLayout {
    var position: FloatingPanelPosition = .bottom
    var initialState: FloatingPanelState = .tip
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
            return [
                .full: FloatingPanelLayoutAnchor(fractionalInset: 1.0, edge: .bottom, referenceGuide: .superview),
                .half: FloatingPanelLayoutAnchor(fractionalInset: 0.8, edge: .bottom, referenceGuide: .superview),
                .tip: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .superview)
            ]
    }
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat { // 뒷 배경
        0.3
    }
}
