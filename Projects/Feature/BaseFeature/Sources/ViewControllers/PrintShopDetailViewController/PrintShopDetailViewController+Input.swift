//
//  PrintShopDetailViewController+Input.swift
//  BaseFeature
//
//  Created by 박의서 on 2023/11/13.
//  Copyright © 2023 com. All rights reserved.
//

import UIKit
import RxSwift
import UtilityModule

extension PrintShopDetailViewController {
    func bindButton() {
        callButton.rx.tap
            .subscribe { [weak self] in
                guard let self else { return }
                
                let number = printShopTmp.phone
                DEBUG_LOG("핸드폰")
                if let url = NSURL(string: "tel://0" + "\(number)"),
                   
                    //canOpenURL(_:) 메소드를 통해서 URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
                   UIApplication.shared.canOpenURL(url as URL) {
                    
                    //사용가능한 URLScheme이라면 만들어둔 URL 인스턴스를 열어줍니다.
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                }
            }
            .disposed(by: disposeBag)
    }
}
