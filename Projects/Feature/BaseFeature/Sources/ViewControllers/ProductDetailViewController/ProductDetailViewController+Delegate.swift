//
//  ProductDetailViewController+Delegate.swift
//  BaseFeatureDemo
//
//  Created by yongbeomkwak on 11/1/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UIKit
import UtilityModule
import FloatingPanel

extension ProductDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 542
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProductDetailTableHeaderView.identifer) as? ProductDetailTableHeaderView  else {
            return nil
        }
        
        headerview.update()
        headerview.delegate = self 
        
        return headerview
    }
}

extension ProductDetailViewController: ProductDetailTableHeaderViewDelegate {
    func save(id: Int, isBookmarked: Bool) {
        
        
        if PreferenceManager.user == nil { // 로그인 안되어있음
            
            input.askToast.onNext("로그인이 필요한 서비스입니다.")
            
            return
        }
        
        if !isBookmarked { // 로그인 되어 있는데 북마크에 없음
            // 추가
            let vc = bookMarkBottomSheetFactory.makeView(id: id)
            
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
            fpc.backdropView.dismissalTapGestureRecognizer.isEnabled = true
            
            // Hidden grabber
            fpc.surfaceView.grabberHandle.isHidden = true
            
            fpc.addPanel(toParent: self)
            
            fpc.layout = CustomFloatingPanelLayout()
           
            
            UIView.animate(withDuration: 0.4) {
                self.fpc.move(to: .half, animated: false)
            }
            
            fpc.show()
            
            
        }
        
        else {
            input.askToast.onNext("성공적으로 삭제했습니다.")
        }
    }
}
