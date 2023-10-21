//
//  MyPageViewModel.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule
import UserDomainInterface

public enum MyPageCategory: String {
    case pushAlarmSetting = "앱 푸시 알림 설정"
    case faq = "자주 묻는 질문"
    case request = "1:1 문의하기"
    case service = "서비스 이용약관"
}

final class MyPageContentViewModel : ViewModelType {
 
    let categories:[MyPageCategory] = [.pushAlarmSetting, .faq, .request, .service]
    
    var fetchUserInfoUseCase: any FetchUserInfoUseCase
    var renameUserUseCase: any RenameUserUseCase
    
    init(fetchUserInfoUseCase: FetchUserInfoUseCase, renameUserUseCase: RenameUserUseCase) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.renameUserUseCase = renameUserUseCase
    }
    
    struct Input {
        
    }
    
    struct Output{
        
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
}
