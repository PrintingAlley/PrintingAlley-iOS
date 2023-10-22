//
//  MyPageContentViewController+Delegate.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 10/21/23.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import DesignSystem
import MessageUI // import For MailSystem

extension MyPageContentViewController: MyPageHeaderViewDelegate {
    public func headerTap(type: HeaderItemType) {
        
        
        switch type {
            
        case .notice:
            DEBUG_LOG(type)
        case .bookMark:
            
            let vc = bookMarkFactory.makeView()
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .review:
            DEBUG_LOG(type)
        }
    }
 
}

extension MyPageContentViewController: MyPageFooterViewDelegate {
    public func action(type: UserLogoutAction) {
        
        switch type {
            
        case .logout:
            input.tapLogOut.onNext(())
        case .withdraw:
            
            let vc = AlertViewController(title:"탈퇴하시나요?", content: "탈퇴하시면 이용 중인 인쇄골목이\n패쇄되며, 모든 데이터는 복구가 불\n가능합니다.",type:  .delete, completion: { [weak self] in
                
                guard let self else {return}
                
                self.input.tapWithDraw.onNext(())
                
            })
            
            vc.modalPresentationStyle = .overFullScreen
            self.present(vc, animated: false)
            
        }
        
    }
    
}

extension MyPageContentViewController: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true) {
            if let error = error {
                DEBUG_LOG(error.localizedDescription)
            }
            
        }
    }
}
