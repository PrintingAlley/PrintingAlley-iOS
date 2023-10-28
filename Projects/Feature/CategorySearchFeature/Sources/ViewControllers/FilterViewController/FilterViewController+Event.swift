//
//  FilterViewController+Event.swift
//  CategorySearchFeature
//
//  Created by yongbeomkwak on 10/28/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import UtilityModule


extension FilterViewController {
    @objc func tapRefresh() {
        viewModel.fillterIdSet.removeAll()
        NotificationCenter.default.post(name:.refreshFilter , object: nil)
    }
    
    @objc func tapFind() {
        self.dismiss(animated: true)
        self.deleagte?.receive(result: Array<Int>(viewModel.fillterIdSet))
    }
    
    @objc func tapClose() {
        self.dismiss(animated: true)
    }
    
    @objc func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        let distance = gestureRecognizer.translation(in: self.view)
        let height = APP_HEIGHT()
        
        switch gestureRecognizer.state {
                case .began:
                    return
                    
                case .changed:
                    let distanceY = max(distance.y, 0)
                    view.frame = CGRect(x: 0, y: distanceY, width: view.frame.width, height: height)
                    let opacity = 1 - (distanceY / height)

                    self.updateOpacity(value: Float(opacity))
                    
                case .ended:
                    let velocity = gestureRecognizer.velocity(in: self.view)
                    
                    // 빠르게 드래그하거나 화면의 40% 이상 드래그 했을 경우 dismiss
                    if velocity.y > 1000 || view.frame.origin.y > (height * 0.3) {
                        dismiss(animated: true)
                    } else {
                        UIView.animate(withDuration: 0.35,
                                       delay: 0.0,
                                       usingSpringWithDamping: 0.8,
                                       initialSpringVelocity: 0.8,
                                       options: [.curveEaseInOut],
                                       animations: {
                            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: height)
                            self.updateOpacity(value: 1)
                        })
                    }
                    
                default:
                    break
                }
    }
    
    func updateOpacity(value: Float) {
        self.view.layer.opacity = value
    }
}
