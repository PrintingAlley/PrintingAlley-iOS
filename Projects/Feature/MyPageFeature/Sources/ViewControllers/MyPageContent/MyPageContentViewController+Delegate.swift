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
            input.tapWithDraw.onNext(())
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
