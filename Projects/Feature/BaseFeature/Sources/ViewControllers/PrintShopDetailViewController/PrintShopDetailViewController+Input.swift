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
            .subscribe(onNext: { [weak self] in
                guard let self else { return }

                let number = self.output.dataSource.value.phone

                if let url = NSURL(string: "tel:" + "\(number)"),
                   UIApplication.shared.canOpenURL(url as URL) { // URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil) // 만들어둔 URL 인스턴스를 열어줌
                }
            })
            .disposed(by: disposeBag)
    }
}
