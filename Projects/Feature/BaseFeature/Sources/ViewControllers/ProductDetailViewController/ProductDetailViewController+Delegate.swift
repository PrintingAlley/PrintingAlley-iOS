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
import BaseDomainInterface
import DesignSystem

extension ProductDetailViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        
//        
//        let space = APP_WIDTH() - 85-5
//        
//        let tempLabel = AlleyLabel(output.headerInfo.value.title,textColor: .sub(.black), font: .header3).then {
//            $0.sizeToFit()
//            $0.lineBreakMode = .byWordWrapping
//        }
//        
//        DEBUG_LOG("SPC: \(space) \(tempLabel.frame.width)")
//        
//        return space > tempLabel.frame.width ? 492 : 510
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProductDetailTableHeaderView.identifer) as? ProductDetailTableHeaderView  else {
            return nil
        }
        
        headerview.update(model: output.headerInfo.value, isSaved: viewModel.isSaved)
        headerview.delegate = self
        
        return headerview
    }
}

extension ProductDetailViewController: ProductDetailTableHeaderViewDelegate {
    func save(id: Int, isBookmarked: Bool) {
        
        
        if PreferenceManager.user == nil { // 로그인 안되어있음
            
            input.askToast.onNext(BaseEntity(statusCode: 0, message: "로그인이 필요한 서비스입니다."))
            
            return
        }
        
        if !isBookmarked { // 로그인 되어 있는데 북마크에 없음
            // 추가
            guard let vc = bookMarkBottomSheetFactory.makeView(id: id) as? BookMarkBottomSheetViewController else {
                return
            }
            
            vc.delegate = self
            
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
            
            input.removeItem.onNext(())
            
        }
    }
}


extension ProductDetailViewController: ProductDetailTableViewCellDelegate {
    func copy(text: String) {
        COPY(text: text)
        
        input.askToast.onNext(BaseEntity(statusCode: 0, message: "클립보드에 복사되었습니다\n인쇄사 찾기에서 바로 검색해보세요"))
    }
    
}


extension ProductDetailViewController: BookMarkBottomSheetViewControllerDelegate {
    func success(id: Int) { // 세이브 성공 했으니 저장상태 업데이트
        viewModel.isSaved = true
        viewModel.bookMarkId = id // 저장 후 삭제할 때 사용할 북마크 id
        tableView.reloadData()
    }
    
}
