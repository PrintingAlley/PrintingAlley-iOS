//
//  MyPageViewModel.swift
//  MyPageFeature
//
//  Created by yongbeomkwak on 2023/09/30.
//  Copyright © 2023 com. All rights reserved.
//

import Foundation
import UtilityModule

public enum MyPageCategory: String {
    case notice = "공지사항"
    case faq = "자주 묻는 질문"
    case request = "1:1 문의하기"
    case service = "서비스 이용약관"
}

final class MyPageContentViewModel : ViewModelType {
 
    let categories:[MyPageCategory] = [.notice,.faq,.request,.service]
    
    struct Input{
        
    }
    
    struct Output{
        
    }
    
    func transform(input: Input) -> Output {
        let output = Output()
        
        return output
    }
}
