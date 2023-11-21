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


extension MyPageContentViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertVc = AlertViewController(title:"준비 중입니다.", content: "조금만 기다려주세요!", type:  .onlyConfirm)
        
        alertVc.modalPresentationStyle = .overFullScreen
        
        switch viewModel.categories[indexPath.row] {
            //TODO: 추후 해당 화면 이동 코드
        case .pushAlarmSetting:
            self.present(alertVc, animated: false)
        case .faq:
            self.present(alertVc, animated: false)
        case .request:
            showMail()
            
        case .service:
            let vc = webViewFactory.makeView(title: viewModel.categories[indexPath.row].rawValue, url: "\(WEB_URL())/policy/service")
            
            vc.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .copyright:
            
            let vc = webViewFactory.makeView(title: viewModel.categories[indexPath.row].rawValue, url: "\(WEB_URL())/policy/copyright")
            
            vc.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension MyPageContentViewController: MyPageHeaderViewDelegate {
    public func headerTap(type: HeaderItemType) {
        
        
        
        let vc = AlertViewController(title:"준비 중입니다.", content: "조금만 기다려주세요!", type:  .onlyConfirm)
        
        vc.modalPresentationStyle = .overFullScreen
        
        
        switch type {
            
        case .notice:
            self.present(vc, animated: false)
        case .bookMark:
            
            let vc = bookMarkFactory.makeView()
            
            vc.hidesBottomBarWhenPushed = true //탭바 숨김
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        case .review:
            self.present(vc, animated: false)
        }
    }
 
}

extension MyPageContentViewController: MyPageFooterViewDelegate {
    public func action(type: UserLogoutAction) {
        
        switch type {
            
        case .logout:
            input.tapLogOut.onNext(())
        case .withdraw:
            
            let vc = AlertViewController(title:"탈퇴하시나요?", content: "저장목록, 리뷰 등 활동 정보가 전부 사라지고 다시 복구할 수 없어요", type:  .withDraw, completion: { [weak self] in
                
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
